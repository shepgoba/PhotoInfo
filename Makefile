INSTALL_TARGET_PROCESSES = MobileSlideShow

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PhotoInfo

PhotoInfo_FILES = Tweak.xm
PhotoInfo_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
