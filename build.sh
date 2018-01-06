#!/bin/bash
#based on https://github.com/glance-/pulseaudio-android-ndk

set -e

if [ "${BUILD_CONFIG}" != "0" ] ; then
	. config
fi

if [ "${TRACE}" == "1" ] ; then
	set -x
fi

export ANDROID_NDK_ROOT
export ARCH

#set ARCH if it is not set before
if [ ! -n "$ARCH" ]; then
	ARCH="arm"
fi

if [ "$ARCH" = "arm" ] ; then
	BUILDCHAIN=arm-linux-androideabi
elif [ "$ARCH" = "x86" ] ; then
	BUILDCHAIN=i686-linux-android
elif [ "$ARCH" = "x86_64" ] ; then
	BUILDCHAIN=x86_64-linux-android
fi

LIBTOOL_VERSION=2.4.6
LIBSNDFILE_VERSION=1.0.27
PULSE_VERSION=v11.1

if [ ! -e "ndk-$ARCH" ] ; then
	"$ANDROID_NDK_ROOT"/build/tools/make_standalone_toolchain.py --arch="$ARCH" --install-dir="ndk-$ARCH" --api=21
fi

export BUILDROOT=$PWD
export PATH=${BUILDROOT}/out-$ARCH/bin:${BUILDROOT}/ndk-$ARCH/bin:$PATH
export PREFIX=${BUILDROOT}/out-$ARCH/usr
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
export CC="${BUILDCHAIN}-gcc -fPIE -pie"
export CXX="${BUILDCHAIN}-g++ -fPIE -pie"
export CFLAGS="-I${PREFIX}/include -L${PREFIX}/lib"
export CPPFLAGS="-Dposix_madvise=madvise -DPOSIX_MADV_WILLNEED=MADV_WILLNEED"
export ACLOCAL_PATH=${PREFIX}/share/aclocal

mkdir -p ${PREFIX}

# Fetch external repos
if [ ! -e pulseaudio/bootstrap.sh ] ; then
	git clone git://anongit.freedesktop.org/pulseaudio/pulseaudio -b $PULSE_VERSION
fi

if [ ! -e libtool-$LIBTOOL_VERSION.tar.gz ] ; then
	wget http://ftpmirror.gnu.org/libtool/libtool-$LIBTOOL_VERSION.tar.gz
fi

if [ ! -e libsndfile-$LIBSNDFILE_VERSION.tar.gz ] ; then
	wget http://www.mega-nerd.com/libsndfile/files/libsndfile-$LIBSNDFILE_VERSION.tar.gz
fi

#unpack external repos
if [ ! -e libtool-$LIBTOOL_VERSION ] ; then
	tar -zxf libtool-$LIBTOOL_VERSION.tar.gz
fi

if [ ! -e libsndfile-$LIBSNDFILE_VERSION ] ; then
	tar -zxf libsndfile-$LIBSNDFILE_VERSION.tar.gz
fi

mkdir -p "${BUILDROOT}/build-$ARCH"

#now we can build all off that stuff!
if [ ! -e "${PREFIX}/lib/libltdl.a" ] ; then
	mkdir -p "${BUILDROOT}/build-$ARCH/libtool"
	pushd "${BUILDROOT}/build-$ARCH/libtool"
	${BUILDROOT}/libtool-$LIBTOOL_VERSION/configure --host=${BUILDCHAIN} --prefix="${PREFIX}" \
		HELP2MAN=/bin/true MAKEINFO=/bin/true --disable-shared --enable-static
	make -j4
	make install
	popd
fi

# Now, use updated libtool
export LIBTOOLIZE=${PREFIX}/bin/libtoolize

if [ ! -e "$PKG_CONFIG_PATH/sndfile.pc" ] ; then
	mkdir -p "${BUILDROOT}/build-$ARCH/libsndfile"
	pushd "${BUILDROOT}/build-$ARCH/libsndfile"
	${BUILDROOT}/libsndfile-$LIBSNDFILE_VERSION/configure --host=${BUILDCHAIN} --prefix="${PREFIX}" \
		--disable-external-libs --disable-alsa 	--disable-sqlite --disable-shared --enable-static
	# Hack out examples, which doesn't build
	perl -pi -e 's/ examples / /g' Makefile
	make -j4
	make install
	popd
fi

pushd pulseaudio
# disable patching for now..
#if ! git grep -q opensl ; then
#	git am ../pulseaudio-patches/*
#fi
cp -f ${BUILDROOT}/module-sles-sink.c ${BUILDROOT}/pulseaudio/src/modules/
if grep -q "module-sles-sink" ${BUILDROOT}/pulseaudio/src/Makefile.am; then
    printf ""
else
	patch -p0 < ${BUILDROOT}/patches/000-pulseaudio.patch
fi
env NOCONFIGURE=1 bash -x ./bootstrap.sh
#./autogen.sh
popd

mkdir -p "${BUILDROOT}/build-$ARCH/pulseaudio"
pushd "${BUILDROOT}/build-$ARCH/pulseaudio"
if [ ! -e ${BUILDROOT}/build-$ARCH/pulseaudio/config.log ]; then
${BUILDROOT}/pulseaudio/configure --host=${BUILDCHAIN} --prefix="${PREFIX}" \
		--disable-static --enable-shared --disable-rpath --disable-nls --disable-x11 \
		--disable-oss-wrapper --disable-alsa --disable-esound --disable-waveout \
		--disable-glib2 --disable-gtk3 --disable-gconf --disable-avahi --disable-jack \
		--disable-asyncns --disable-tcpwrap --disable-lirc --disable-dbus --disable-bluez4 \
		--disable-bluez5 --disable-udev --disable-openssl --disable-xen --disable-systemd \
		--disable-manpages --disable-samplerate --without-speex --with-database=simple \
		--disable-orc --without-caps --without-fftw --disable-systemd-daemon \
		--disable-systemd-login --disable-systemd-journal --disable-webrtc-aec --disable-tests
# --enable-static-bins
fi
make -j4
make install
