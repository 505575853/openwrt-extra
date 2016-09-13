#
# Copyright (C) 2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=orbiter
PKG_REV=92378b5
PKG_VERSION:=0.2r$(PKG_REV)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-git-$(PKG_SOURCE_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/stevedonovan/Orbiter.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=0

include $(INCLUDE_DIR)/package.mk

define Package/orbiter
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Orbiter
  PKGARCH:=all
  URL:=https://github.com/stevedonovan/Orbiter
  DEPENDS:=+lua +luasocket
endef

define Package/orbiter/description
  A self-contained personal Web Framework
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/Install
endef


define Package/orbiter/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/
	$(CP) -r $(PKG_BUILD_DIR)/orbiter $(1)/usr/lib/lua/
	
endef

$(eval $(call BuildPackage,orbiter))
