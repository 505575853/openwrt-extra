#
# Copyright (C) 2007-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=njit8021xclient
PKG_VERSION:=1.3.1
PKG_RELEASE:=2

#PKG_REV=v$(PKG_VERSION)
PKG_REV=9516540

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-rev.$(PKG_REV).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_URL:=https://github.com/liuqun/njit8021xclient.git

include $(INCLUDE_DIR)/package.mk

define Package/njit8021xclient
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libpcap
	PKG_BUILD_DEPENDS:=+libopenssl
	TITLE:=An CERNET client daemon
	URL:=https://github.com/liuqun/njit8021xclient
	SUBMENU:=CERNET
endef

CONFIGURE_ARGS += \
	--program-prefix="njit-" \
	$(NULL)

define Build/Prepare
	$(call Build/Prepare/Default)
endef

define Build/Configure
	cd $(PKG_BUILD_DIR) && \
		sed -i -e '1s/^AC/AUTOMAKE_OPTIONS = subdir-objects\nAC/' \
		-e 's/INCLS = .*/INCLS = /g' \
		src/Makefile.am
	cd $(PKG_BUILD_DIR) && autoreconf --install
	$(call Build/Configure/Default)
endef


define Package/njit8021xclient/install
	$(MAKE) -C $(PKG_BUILD_DIR) install-exec DESTDIR=$(1)
endef

define Package/njit8021xclient/conffiles
/etc/config/njit8021xclient.conf
endef

define Package/luci-app-njit8021xclient
  SECTION:=LuCI
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI pages for NJIT 802.1X client
  URL:=http://sourceforge.net/projects/njit8021xclient/
  DEPENDS:=njit8021xclient
  PKGARCH:=all
endef

define Package/luci-app-njit8021xclient/description
  LuCI web pages of njit8021xclient.
endef

define Package/luci-app-njit8021xclient/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src-gui/luci/luci_controller_njit.lua \
		$(1)/usr/lib/lua/luci/controller/njit.lua
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src-gui/luci/njit.lua \
		$(1)/usr/lib/lua/luci/model/cbi/njit.lua
endef

$(eval $(call BuildPackage,njit8021xclient))
$(eval $(call BuildPackage,luci-app-njit8021xclient))
