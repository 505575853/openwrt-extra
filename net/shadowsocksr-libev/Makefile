include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocksr-libev
PKG_VERSION:=2.5.6
PKG_RELEASE=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/shadowsocksr-backup/shadowsocksr-libev.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=e2373d7199102f383b741da148b989c7c1e8832e
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MAINTAINER:=shadowsocksr-backup

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocksr-libev/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Lightweight Secured Socks5 Proxy
  URL:=https://github.com/shadowsocksr-backup/shadowsocksr-libev
endef

define Package/shadowsocksr-libev
  $(call Package/shadowsocksr-libev/Default)
  TITLE+= (OpenSSL)
  VARIANT:=openssl
  DEPENDS:=+libopenssl +zlib +ipset +!PACKAGE_ip-full:ip +iptables-mod-tproxy +libpcre
endef

define Package/shadowsocksr-libev-polarssl
  $(call Package/shadowsocksr-libev/Default)
  TITLE+= (PolarSSL)
  VARIANT:=polarssl
  DEPENDS:=+libpolarssl +zlib +ipset +!PACKAGE_ip-full:ip +iptables-mod-tproxy +libpcre
endef

define Package/shadowsocksr-libev-server
  $(call Package/shadowsocksr-libev/Default)
  TITLE+= (OpenSSL)
  VARIANT:=openssl
  DEPENDS:=+libopenssl +libpthread +zlib
endef

define Package/shadowsocksr-libev-server-polarssl
  $(call Package/shadowsocksr-libev/Default)
  TITLE+= (PolarSSL)
  VARIANT:=polarssl
  DEPENDS:=+libpolarssl +libpthread +zlib
endef

define Package/shadowsocksr-libev/description
Shadowsocks-libev is a lightweight secured scoks5 proxy for embedded devices and low end boxes.(with obfs support)
endef

Package/shadowsocksr-libev-polarssl/description=$(Package/shadowsocksr-libev/description)

Package/shadowsocksr-libev-server/description=$(Package/shadowsocksr-libev/description)

Package/shadowsocksr-libev-server-polarssl/description=$(Package/shadowsocksr-libev/description)

define Package/shadowsocksr-libev/conffiles
/etc/shadowsocks.json
endef

ifeq ($(BUILD_VARIANT),polarssl)
	CONFIGURE_ARGS += --with-crypto-library=polarssl
endif

TARGET_CFLAGS += \
	-fdata-sections \
	-ffunction-sections

TARGET_LDFLAGS += \
	-Wl,-gc-sections

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

define Package/shadowsocksr-libev/install
	$(INSTALL_DIR) $(1)/etc/init.d $(1)/etc/config
	$(INSTALL_CONF) ./files/shadowsocksr.json $(1)/etc
	$(INSTALL_BIN) ./files/shadowsocksr.init $(1)/etc/init.d/shadowsocksr-libev
	$(INSTALL_BIN) ./files/shadowsocksr.config $(1)/etc/config/shadowsocksr-libev
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-local $(1)/usr/bin/ssr-local
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-redir $(1)/usr/bin/ssr-redir
	# $(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-tunnel $(1)/usr/bin/ssr-tunnel
	$(INSTALL_BIN) ./files/ssr-rules $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/shadowsocksr-libev
	$(INSTALL_DATA) ./files/firewall.include $(1)/usr/share/shadowsocksr-libev/firewall.include
endef

define Package/shadowsocksr-libev/postinst
#!/bin/sh
uci -q batch <<-EOF >/dev/null
	delete firewall.shadowsocksr_libev
	set firewall.shadowsocksr_libev=include
	set firewall.shadowsocksr_libev.type=script
	set firewall.shadowsocksr_libev.path=/usr/share/shadowsocksr-libev/firewall.include
	set firewall.shadowsocksr_libev.reload=1
	commit firewall
EOF
exit 0
endef

Package/shadowsocksr-libev-polarssl/postinst=$(Package/shadowsocksr-libev/postinst)

Package/shadowsocksr-libev-polarssl/install=$(Package/shadowsocksr-libev/install)

define Package/shadowsocksr-libev-server/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-server $(1)/usr/bin
endef

Package/shadowsocksr-libev-server-polarssl/install=$(Package/shadowsocksr-libev-server/install)

$(eval $(call BuildPackage,shadowsocksr-libev))
$(eval $(call BuildPackage,shadowsocksr-libev-polarssl))
$(eval $(call BuildPackage,shadowsocksr-libev-server))
$(eval $(call BuildPackage,shadowsocksr-libev-server-polarssl))
