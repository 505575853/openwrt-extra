#
# Copyright (C) 2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=spcdns
PKG_VERSION:=1.0.12
PKG_RELEASE:=1
PKG_REV:=da59956fdad7dc5d66f1229e789eaf228282d29e

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/spc476/SPCDNS.git

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luaspcdns
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=LUA DNS library
  URL:=http://www.conman.org/software/spcdns
  DEPENDS:=+lua
endef

define Package/luaspcdns/description
  A DNS library for LUA
endef

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/ \
		LIBDIR="$(TARGET_LDFLAGS)" \
		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -std=gnu99" \
		LD="$(TARGET_CROSS)ld -shared" \
		all
endef


define Package/luaspcdns/install
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/org
	$(INSTALL_DIR) $(1)/usr/lib/lua/org/conman
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/dns.so $(1)/usr/lib/lua/org/conman
endef

$(eval $(call BuildPackage,luaspcdns))
