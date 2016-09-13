#
# Copyright (C) 2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lua-xmlrpc
PKG_REV=50462e2
PKG_VERSION:=0.2r$(PKG_REV)
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/lua-xmlrpc
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Lua XML-RPC
  PKGARCH:=all
  URL:=https://github.com/timn/lua-xmlrpc
  DEPENDS:=+lua +luasocket
endef

define Package/lua-xmlrpc/description
  A self-contained personal Web Framework
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/Install
endef


define Package/lua-xmlrpc/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/xmlrpc
	$(CP) ./files/*.lua $(1)/usr/lib/lua/xmlrpc
	
endef

$(eval $(call BuildPackage,lua-xmlrpc))
