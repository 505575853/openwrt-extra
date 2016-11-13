#
# Copyright (C) 2007 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#


include $(TOPDIR)/rules.mk

PKG_NAME:=proxychains
PKG_VERSION:=git-20161113
PKG_RELEASE:=1


PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/haad/proxychains.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=0f61bd071389398a4c8378847a45973577593e6f

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/proxychains
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Transparent SOCKS proxying library
  URL:=https://github.com/haad/proxychains
endef

define Package/proxychains/description
Transparent SOCKS proxying library
endef

define Build/Prepare
	$(Build/Prepare/Default)
	cd $(PKG_BUILD_DIR) && sed -i 's:sys/poll.h:poll.h:g' src/core.c
endef

define Package/proxychains/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/proxychains4 $(1)/usr/bin/proxychains4
	ln -s proxychains4 $(1)/usr/bin/proxychains
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libproxychains4.so $(1)/usr/lib/
endef

$(eval $(call BuildPackage,proxychains))
