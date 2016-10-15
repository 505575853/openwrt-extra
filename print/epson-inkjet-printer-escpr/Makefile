#
# Copyright (C) 2006-2009 OpenWrt.org
# Copyright (C) 2005-2016 Weijie Gao <hackpascal@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=epson-inkjet-printer-escpr
PKG_VERSION:=1.6.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-1lsb3.2.tar.gz
PKG_SOURCE_URL:=https://download3.ebz.epson.net/dsc/f/03/00/05/12/61/b548695f9c41e714ea5efcd8cf9200de4cdadaff/
PKG_SHA256SUM:=e76e019e5051bfdb6cde970346cab3518c192a8dd87d05f3f3af380ed4542970

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/epson-inkjet-printer-escpr
  SECTION:=print
  CATEGORY:=Printing and Imaging
  TITLE:=Epson Inkjet ESC/P-R printer driver
  DEPENDS:=+libcups +libcupsimage
  MAINTAINER:=Weijie Gao <hackpascal@gmail.com>
endef

define Package/epson-inkjet-printer-escpr/description
  Epson Inkjet ESC/P-R printer driver
endef

CONFIGURE_ARGS += \
	--with-cupsfilterdir="/usr/lib/cups/filter" \
	--with-cupsppddir="/usr/share/ppd"

define Package/epson-inkjet-printer-escpr/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/{libescpr.so,libescpr.so.1,libescpr.so.1.0.0} $(1)/usr/lib

	$(INSTALL_DIR) $(1)/usr/lib/cups/filter
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/cups/filter/{epson-escpr,epson-escpr-wrapper} $(1)/usr/lib/cups/filter/

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/epson-escpr-set-cups-filters-permission $(1)/etc/uci-defaults/
endef

$(eval $(call BuildPackage,epson-inkjet-printer-escpr))
