#
# Copyright (C) 2018 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# define hardware platform
PRODUCT_PLATFORM := sm8150

include device/google/coral/device.mk

# Set Vendor SPL to match platform
VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Set boot SPL
BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

PRODUCT_PROPERTY_OVERRIDES += vendor.audio.adm.buffering.ms=3
PRODUCT_PROPERTY_OVERRIDES += vendor.audio_hal.period_multiplier=2
PRODUCT_PROPERTY_OVERRIDES += af.fast_track_multiplier=1
PRODUCT_PROPERTY_OVERRIDES += vendor.audio.offload.buffer.size.kb=256

# Enable AAudio MMAP/NOIRQ data path.
# 1 is AAUDIO_POLICY_NEVER  means only use Legacy path.
# 2 is AAUDIO_POLICY_AUTO   means try MMAP then fallback to Legacy path.
# 3 is AAUDIO_POLICY_ALWAYS means only use MMAP path.
PRODUCT_PROPERTY_OVERRIDES += aaudio.mmap_policy=2
# 1 is AAUDIO_POLICY_NEVER  means only use SHARED mode
# 2 is AAUDIO_POLICY_AUTO   means try EXCLUSIVE then fallback to SHARED mode.
# 3 is AAUDIO_POLICY_ALWAYS means only use EXCLUSIVE mode.
PRODUCT_PROPERTY_OVERRIDES += aaudio.mmap_exclusive_policy=2

# Increase the apparent size of a hardware burst from 1 msec to 2 msec.
# A "burst" is the number of frames processed at one time.
# That is an increase from 48 to 96 frames at 48000 Hz.
# The DSP will still be bursting at 48 frames but AAudio will think the burst is 96 frames.
# A low number, like 48, might increase power consumption or stress the system.
PRODUCT_PROPERTY_OVERRIDES += aaudio.hw_burst_min_usec=2000

# A2DP offload enabled for compilation
AUDIO_FEATURE_ENABLED_A2DP_OFFLOAD := true

# A2DP offload supported
PRODUCT_PROPERTY_OVERRIDES += \
ro.bluetooth.a2dp_offload.supported=true

# A2DP offload disabled (UI toggle property)
PRODUCT_PROPERTY_OVERRIDES += \
persist.bluetooth.a2dp_offload.disabled=false

# A2DP offload DSP supported encoder list
PRODUCT_PROPERTY_OVERRIDES += \
persist.bluetooth.a2dp_offload.cap=sbc-aac-aptx-aptxhd-ldac

# Enable AAC frame ctl for A2DP sinks
PRODUCT_PROPERTY_OVERRIDES += \
persist.vendor.bt.aac_frm_ctl.enabled=true

# Set lmkd options
PRODUCT_PRODUCT_PROPERTIES += \
	ro.config.low_ram = false \
	ro.lmk.kill_heaviest_task = true \
	ro.lmk.kill_timeout_ms = 100 \
	ro.lmk.use_minfree_levels = true \
	ro.lmk.log_stats = true \

# Modem logging file
PRODUCT_COPY_FILES += \
    device/google/coral/init.logging.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).logging.rc

#TWRP files
PRODUCT_COPY_FILES += \
    device/google/coral/modules/ftm5.ko:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/ftm5.ko \
    device/google/coral/modules/heatmap.ko:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/lib64/heatmap.ko \
    device/google/coral/modules/videobuf2-memops.ko:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/videobuf2-memops.ko \
    device/google/coral/modules/videobuf2-vmalloc.ko:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/videobuf2-vmalloc.ko \
    device/google/coral/touchdriver.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/touchdriver.sh \
    device/google/coral/prebuilts/qseecomd:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/qseecomd \
    device/google/coral/prebuilts/libdrmfs.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libdrmfs.so \
    device/google/coral/prebuilts/libxml2.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libxml2.so \
    device/google/coral/prebuilts/libnetd_client.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnetd_client.so \
    device/google/coral/prebuilts/libspcom.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libspcom.so \
    device/google/coral/prebuilts/libkeymasterdeviceutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libkeymasterdeviceutils.so \
    device/google/coral/prebuilts/libgptutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libgptutils.so \
    device/google/coral/prebuilts/libkeymasterutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libkeymasterutils.so \
    device/google/coral/prebuilts/libqtikeymaster4.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqtikeymaster4.so \
    device/google/coral/prebuilts/libQSEEComAPI.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libQSEEComAPI.so \
    device/google/coral/prebuilts/libdiag.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libdiag.so \
    device/google/coral/prebuilts/libnos_client_citadel.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos_client_citadel.so \
    device/google/coral/prebuilts/libnos_transport.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos_transport.so \
    device/google/coral/prebuilts/citadeld:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/citadeld \
    device/google/coral/prebuilts/android.hardware.keymaster@4.0-service.citadel:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.keymaster@4.0-service.citadel \
    device/google/coral/prebuilts/prepdecrypt.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/prepdecrypt.sh \
    device/google/coral/prebuilts/time_daemon:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/time_daemon \
    device/google/coral/prebuilts/libqmi_cci.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqmi_cci.so \
    device/google/coral/prebuilts/libqmi_common_so.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqmi_common_so.so \
    device/google/coral/prebuilts/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/manifest.xml \
    device/google/coral/prebuilts/fastbootmanifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/manifest.xml  \
    device/google/coral/prebuilts/compatibility_matrix.device.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.device.xml \
    device/google/coral/prebuilts/compatibility_matrix.legacy.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.legacy.xml \
    device/google/coral/prebuilts/android.hardware.gatekeeper@1.0-service-qti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.gatekeeper@1.0-service-qti \
    device/google/coral/prebuilts/android.hardware.keymaster@4.0-service-qti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.keymaster@4.0-service-qti \
    device/google/coral/prebuilts/android.hardware.boot@1.0-service:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.boot@1.0-service \
    device/google/coral/prebuilts/android.hardware.weaver@1.0-impl.nos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.weaver@1.0-impl.nos.so \
    device/google/coral/prebuilts/android.hardware.weaver@1.0-service.citadel:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.weaver@1.0-service.citadel \
    device/google/coral/prebuilts/android.hardware.authsecret@1.0-service.citadel:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.authsecret@1.0-service.citadel \
    device/google/coral/prebuilts/android.hardware.authsecret@1.0-impl.nos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.authsecret@1.0-impl.nos.so \
    device/google/coral/prebuilts/android.hardware.oemlock@1.0-service.citadel:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.oemlock@1.0-service.citadel \
    device/google/coral/prebuilts/nos_app_weaver.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/nos_app_weaver.so \
    device/google/coral/prebuilts/libnos_citadeld_proxy.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos_citadeld_proxy.so \
    device/google/coral/prebuilts/libnos_datagram_citadel.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos_datagram_citadel.so\
    device/google/coral/prebuilts/libprotobuf-cpp-full.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libprotobuf-cpp-full.so \
    device/google/coral/prebuilts/android.hardware.keymaster@4.0-impl.nos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.keymaster@4.0-impl.nos.so \
    device/google/coral/prebuilts/android.hardware.oemlock@1.0-impl.nos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.oemlock@1.0-impl.nos.so \
    device/google/coral/prebuilts/libnos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos.so \
    device/google/coral/prebuilts/libqmi_encdec.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqmi_encdec.so \
    device/google/coral/prebuilts/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so \
    device/google/coral/prebuilts/libnosprotos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnosprotos.so \
    device/google/coral/prebuilts/libqmi_client_qmux.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqmi_client_qmux.so \
    device/google/coral/prebuilts/nos_app_avb.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/nos_app_avb.so \
    device/google/coral/prebuilts/nos_app_keymaster.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/nos_app_keymaster.so \
    device/google/coral/prebuilts/libicuuc.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libicuuc.so \
    device/google/coral/prebuilts/libmdmdetect.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libmdmdetect.so \
    device/google/coral/prebuilts/libicui18n.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libicui18n.so \
    device/google/coral/prebuilts/libdsutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libdsutils.so \
    device/google/coral/prebuilts/libqmiservices.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqmiservices.so \
    device/google/coral/prebuilts/librpmb.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/librpmb.so \
    device/google/coral/prebuilts/libssd.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libssd.so \
    device/google/coral/prebuilts/libidl.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libidl.so \
    device/google/coral/prebuilts/libsecureui.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libsecureui.so \
    device/google/coral/prebuilts/libdrmtime.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libdrmtime.so \
    device/google/coral/prebuilts/libqisl.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqisl.so \
    device/google/coral/prebuilts/libGPreqcancel.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libGPreqcancel.so \
    device/google/coral/prebuilts/libops.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libops.so \
    device/google/coral/prebuilts/libStDrvInt.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libStDrvInt.so \
    device/google/coral/prebuilts/libtime_genoff.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libtime_genoff.so \
    device/google/coral/prebuilts/libsecureui_svcsock.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libsecureui_svcsock.so \
    device/google/coral/prebuilts/libspl.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libspl.so \
    device/google/coral/prebuilts/libGPreqcancel_svc.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libGPreqcancel_svc.so \
    device/google/coral/prebuilts/vendor.display.config@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/vendor.display.config@1.0.so \
    device/google/coral/prebuilts/vendor.qti.hardware.tui_comm@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/vendor.qti.hardware.tui_comm@1.0.so \
    device/google/coral/prebuilts/pixelpowerstats_provider_aidl_interface-cpp.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/pixelpowerstats_provider_aidl_interface-cpp.so \
    device/google/coral/prebuilts/android.hardware.vibrator@1.3-service.coral:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.vibrator@1.3-service.coral \
    device/google/coral/prebuilts/twrp.flags:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/twrp.flags \
    device/google/coral/prebuilts/ueventd.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.rc \
    device/google/coral/prebuilts/otacerts.zip:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/security/otacerts.zip

# Pixelstats broken mic detection
PRODUCT_PROPERTY_OVERRIDES += vendor.audio.mic_break=true

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.enable_kernel_idle_timer=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.use_color_management=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.has_wide_color_display=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.has_HDR_display=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_idle_timer_ms=80
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_touch_timer_ms=200
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_display_power_timer_ms=1000
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.support_kernel_idle_timer=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.use_smart_90_for_video=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.protected_contents=true

# Must align with HAL types Dataspace
# The data space of wide color gamut composition preference is Dataspace::DISPLAY_P3
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.wcg_composition_dataspace=143261696

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Audio low latency feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml

# Pro audio feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml

# Dmabuf dump tool for bug reports
PRODUCT_PACKAGES += \
    dmabuf_dump

PRODUCT_PACKAGES += \
    magiskboot_arm
# Set thermal warm reset
PRODUCT_PRODUCT_PROPERTIES += \
    ro.thermal_warmreset = true \
