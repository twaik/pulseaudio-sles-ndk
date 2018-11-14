LIBSNDFILE_PATH := $(call my-dir)
LOCAL_PATH := $(LIBSNDFILE_PATH)/src

include $(CLEAR_VARS)

LOCAL_MODULE := libsndfile_pulse
LOCAL_CFLAGS := -std=gnu11 -DHAVE_CONFIG_H -w
LOCAL_SRC_FILES := sndfile.c aiff.c au.c avr.c caf.c dwd.c flac.c g72x.c htk.c ircam.c \
		macos.c mat4.c mat5.c nist.c paf.c pvf.c raw.c rx2.c sd2.c \
		sds.c svx.c txw.c voc.c wve.c w64.c wavlike.c wav.c xi.c mpc2k.c rf64.c \
		ogg_vorbis.c ogg_speex.c ogg_pcm.c ogg_opus.c
LOCAL_SRC_FILES += common.c file_io.c command.c pcm.c ulaw.c alaw.c \
		float32.c double64.c ima_adpcm.c ms_adpcm.c gsm610.c dwvw.c vox_adpcm.c \
		interleave.c strings.c dither.c cart.c broadcast.c audio_detect.c \
 		ima_oki_adpcm.c alac.c chunk.c ogg.c chanmap.c \
		windows.c id3.c
LOCAL_SRC_FILES += GSM610/add.c GSM610/code.c GSM610/decode.c GSM610/gsm_create.c \
		GSM610/gsm_decode.c GSM610/gsm_destroy.c GSM610/gsm_encode.c \
		GSM610/gsm_option.c GSM610/long_term.c GSM610/lpc.c GSM610/preprocess.c \
		GSM610/rpe.c GSM610/short_term.c GSM610/table.c
LOCAL_SRC_FILES += G72x/g721.c G72x/g723_16.c G72x/g723_24.c G72x/g723_40.c G72x/g72x.c
LOCAL_SRC_FILES += ALAC/ALACBitUtilities.c ALAC/ag_dec.c \
		ALAC/ag_enc.c ALAC/dp_dec.c ALAC/dp_enc.c ALAC/matrix_dec.c \
		ALAC/matrix_enc.c ALAC/alac_decoder.c ALAC/alac_encoder.c

LOCAL_C_INCLUDES := $(LIBSNDFILE_PATH) $(LOCAL_PATH)
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
LOCAL_STATIC_LIBRARIES := libFLAC_pulse libogg_pulse libvorbis_pulse

include $(BUILD_STATIC_LIBRARY)
