#
# Copyright (C) 2007-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=EasyDrcom
PKG_VERSION:=0.9
PKG_RELEASE:=1

PKG_REV=1fb5a8b

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-r$(PKG_REV).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_URL:=https://github.com/coverxit/EasyDrcom.git

include $(INCLUDE_DIR)/package.mk

define Package/EasyDrcom
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libstdcpp +libpcap +libpthread
	TITLE:=An CERNET client daemon
	URL:=https://github.com/coverxit/EasyDrcom
	SUBMENU:=CERNET
endef

define Build/Compile
	cd $(PKG_BUILD_DIR)/EasyDrcom && $(TARGET_CROSS)g++ -DOPENWRT -DLINUX -Os -s -std=c++0x -o EasyDrcom md5.c main.cpp -lpcap -lpthread
	#cd $(PKG_BUILD_DIR)/EasyDrcom && $(TARGET_CROSS)strip -s EasyDrcom
endef

define Package/EasyDrcom/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/EasyDrcom/EasyDrcom $(1)/usr/bin/EasyDrcom
	$(INSTALL_DATA) ./files/EasyDrcom.conf $(1)/etc/EasyDrcom.conf
endef

$(eval $(call BuildPackage,EasyDrcom))
