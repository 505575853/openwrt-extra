#
# Copyright (C) 2007-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ffmpegthumbnailer
PKG_VERSION:=2.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/dirkvdb/ffmpegthumbnailer/releases/download/$(PKG_VERSION)/
PKG_MD5SUM:=ed3754b3b8b9af93a93c490e17def0d0

#include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += -DCMAKE_BUILD_TYPE=Release
CMAKE_OPTIONS += -DENABLE_GIO=OFF
CMAKE_OPTIONS += -DENABLE_THUMBNAILER=ON

PKG_INSTALL:=1

define Package/$(PKG_NAME)
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:= +libpng +libjpeg +libstdcpp +libffmpeg-full
  TITLE:=Lightweight video thumbnailer
  URL:=https://github.com/dirkvdb/ffmpegthumbnailer
endef

TARGET_CFLAGS += $(FPIC)

define Build/InstallDev
	$(INSTALL_DIR) $(2)/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/ffmpegthumbnailer \
		$(2)/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libffmpegthumbnailer.so.* \
		$(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/include/libffmpegthumbnailer
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/libffmpegthumbnailer/* \
		$(1)/usr/include/libffmpegthumbnailer/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libffmpegthumbnailer.so.* $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/ffmpegthumbnailer $(1)/usr/bin/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
