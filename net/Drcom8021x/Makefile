#
# Copyright (C) 2007-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=Drcom8021x
PKG_VERSION:=0.9
PKG_RELEASE:=1

PKG_REV=1fb5a8b

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-r$(PKG_REV).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_URL:=https://github.com/coverxit/Drcom8021x.git

PKG_BUILD_DEPENDS:=boost

include $(INCLUDE_DIR)/package.mk

define Package/Drcom8021x
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libstdcpp +libc +libpcap
	TITLE:=An CERNET client daemon
	URL:=https://github.com/coverxit/Drcom8021x
	SUBMENU:=CERNET
endef

define Build/Compile
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)gcc -I$(PKG_BUILD_DIR)/header -Os -c -o md5.o md5.c
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)g++ -I$(PKG_BUILD_DIR)/header -Os -c -o config.o config.cpp
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)g++ -I$(PKG_BUILD_DIR)/header -Os -c -o eap_dealer.o eap_dealer.cpp
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)g++ -I$(PKG_BUILD_DIR)/header -Os -c -o function.o function.cpp
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)g++ -I$(PKG_BUILD_DIR)/header -Os -c -o get_nic_addr.o get_nic_addr.cpp
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)g++ -I$(PKG_BUILD_DIR)/header -Os -c -o main.o main.cpp
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)g++ -I$(PKG_BUILD_DIR)/header -Os -c -o pcap_dealer.o pcap_dealer.cpp
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)g++ -I$(PKG_BUILD_DIR)/header -Os -c -o utils.o utils.cpp
	cd $(PKG_BUILD_DIR)/src && $(TARGET_CROSS)g++ -s -o Drcom8021x md5.o config.o eap_dealer.o function.o get_nic_addr.o \
		main.o pcap_dealer.o utils.o -lpcap
	
endef

define Package/Drcom8021x/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/Drcom8021x $(1)/usr/bin/Drcom8021x
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/Release/Drcom8021x.conf $(1)/etc/Drcom8021x.conf
endef

$(eval $(call BuildPackage,Drcom8021x))
