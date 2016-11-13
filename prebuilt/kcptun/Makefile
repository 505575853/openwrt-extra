#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kcptun
PKG_VERSION:=20161111
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://medetashi.webutu.com/lede/archives/
PKG_MD5SUM:=d7bb08dc3896061edd02e4d3e75f1eb1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

ifeq ($(CONFIG_BIG_ENDIAN),y)
	ENDIAN := eb
else
	ENDIAN := el
endif

define Build/Compile
endef

define Package/kcptun-client
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=A Simple UDP Tunnel Based On KCP(Client)
	URL:=https://github.com/xtaci/kcptun
endef

define Package/kcptun-client/description
A Simple UDP Tunnel Based On KCP(Client)
endef

RSTRIP:=:

define Package/kcptun-client/install
	$(INSTALL_DIR) $(1)/usr/bin/kcptun/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(ARCH)-$(ENDIAN)/client $(1)/usr/bin/kcptun/
endef



define Package/kcptun-server
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=A Simple UDP Tunnel Based On KCP(Server)
	URL:=https://github.com/xtaci/kcptun
endef

define Package/kcptun-server/description
A Simple UDP Tunnel Based On KCP(Server)
endef

define Package/kcptun-server/install
	$(INSTALL_DIR) $(1)/usr/bin/kcptun/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(ARCH)-$(ENDIAN)/server $(1)/usr/bin/kcptun/
endef

$(eval $(call BuildPackage,kcptun-client))
$(eval $(call BuildPackage,kcptun-server))
