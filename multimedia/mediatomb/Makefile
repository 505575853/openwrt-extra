#
# maz-1 < ohmygod19993@gmail.com >

include $(TOPDIR)/rules.mk

PKG_NAME:=mediatomb
PKG_VERSION:=0.13.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/v00d00/$(PKG_NAME).git
PKG_SOURCE_VERSION:=5003c501d2634e85477125675fd6cb36c61c3018
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

CMAKE_INSTALL:=1

#include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += -DWITH_CURL=1
CMAKE_OPTIONS += -DWITH_TAGLIB=1
CMAKE_OPTIONS += -DWITH_MAGIC=1
CMAKE_OPTIONS += -DWITH_AVCODEC=1
CMAKE_OPTIONS += -DLIBAV_ROOT_DIR="$(PKG_INSTALL_DIR)/usr"
CMAKE_OPTIONS += -DWITH_EXIF=1

define Package/$(PKG_NAME)
	SECTION:=multimedia
	CATEGORY:=Multimedia
	TITLE:=$(PKG_NAME)
	DEPENDS:=+libstdcpp +libupnp +libuuid +libexpat +libsqlite3 +curl +libmagic +libffmpeg +libexif +taglib
	URL:=https://github.com/v00d00/mediatomb
	MAINTAINER:=Ian Whyman <thev00d00@gentoo.org>
endef

define Build/Configure
	cd $(PKG_BUILD_DIR) && sed -i 's/EXif/EXIF/g' CMakeLists.txt
	$(call Build/Configure/Default)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/mediatomb $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/mediatomb $(1)/usr/share/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
