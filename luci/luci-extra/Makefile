include $(TOPDIR)/rules.mk

LUCI_TOPDIR=..

PKG_NAME:=luci-extra-maz1
PKG_RELEASE:=1

PKG_BUILD_PARALLEL:=0

PKG_VERSION:=2016-10-13

PKG_BUILD_DEPENDS:=$(if $(STAGING_DIR_ROOT),lua/host)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_INSTALL_DIR:=$(PKG_BUILD_DIR)/ipkg-install

LUA_TARGET:=source
LUCI_CFLAGS:=
LUCI_BUILD_PACKAGES:=
LUCI_SELECTED_MODULES:=

LUAC:="$(STAGING_DIR)/host/bin/luac"

ifeq ($(BOARD),brcm-2.4)
  MAKE_FLAGS += CRAP="1"
endif

### LuaSrcDiet ###
define SrcDiet
	$(FIND) $(1) -type f -name '*.lua' | while read src; do \
		if LuaSrcDiet --noopt-binequiv -o "$$$$src.o" "$$$$src"; \
		then mv "$$$$src.o" "$$$$src"; fi; \
	done
endef

### LuaC ###
define LuaC
	$(FIND) $(1) -type f -name '*.lua' | while read src; do \
		if "$(LUAC)" -s -o "$$$$src.o" "$$$$src"; \
		then mv "$$$$src.o" "$$$$src"; fi; \
	done
endef

### Templates ###
define Package/luci/install/template
	$(CP) -a $(PKG_BUILD_DIR)/$(2)/dist/* $(1)/ -R
	$(CP) -a $(PKG_BUILD_DIR)/$(2)/ipkg/* $(1)/CONTROL/ 2>/dev/null || true
	$(if $(CONFIG_LUCI_SRCDIET),$$(call SrcDiet,$(1)/usr/lib/lua/),true)
	$(if $(CONFIG_LUCI_BYTECODE),$$(call LuaC,$(1)/usr/lib/lua/),true)
endef

### Applications ###
define application
  define Package/luci-app-$(1)
    SECTION:=luci
    CATEGORY:=LuCI
    TITLE:=LuCI - Lua Configuration Interface
    URL:=https://github.com/openwrt-stuff/openwrt-extra/
    MAINTAINER:=maz-1 <ohmygod19993@gmail.com>
    PKGARCH:=all
    SUBMENU:=3. Applications
    TITLE:=$(if $(2),$(2),LuCI $(1) application)
	DEPENDS:=$(3)
  endef

  define Package/luci-app-$(1)/install
	$(call Package/luci/install/template,$$(1),applications/luci-$(1))
  endef

  ifneq ($(CONFIG_PACKAGE_luci-app-$(1)),)
    LUCI_SELECTED_MODULES+=applications/luci-$(1)
  endif

  LUCI_BUILD_PACKAGES += luci-app-$(1)
endef

### Protocol ###
define protocol
  define Package/luci-proto-$(1)
    SECTION:=luci
    CATEGORY:=LuCI
    TITLE:=LuCI - Lua Configuration Interface
    URL:=https://github.com/openwrt-stuff/openwrt-extra/
    MAINTAINER:=maz-1 <ohmygod19993@gmail.com>
    PKGARCH:=all
    SUBMENU:=5. Protocols
    TITLE:=$(if $(2),$(2),LuCI $(1) protocol)
	DEPENDS:=$(3)
  endef

  define Package/luci-proto-$(1)/install
	$(call Package/luci/install/template,$$(1),protocol/luci-$(1))
  endef

  ifneq ($(CONFIG_PACKAGE_luci-proto-$(1)),)
    LUCI_SELECTED_MODULES+=protocol/luci-$(1)
  endif

  LUCI_BUILD_PACKAGES += luci-proto-$(1)
endef



define Package/luci-app-samba4/conffiles
/etc/config/samba4
endef

$(eval $(call application,samba4,LuCI Support for Samba4,\
	+PACKAGE_luci-app-samba4:samba44-server))


#define Package/luci-app-aria2/conffiles
#/etc/config/aria2
#endef

#$(eval $(call application,aria2,LuCI Support for Aria2,\
#	+PACKAGE_luci-app-aria2:aria2 \
#	+PACKAGE_luci-app-aria2:yaaw))


define Package/luci-app-ngrokc/conffiles
/etc/config/ngrokc
endef

$(eval $(call application,ngrokc,LuCI Support for Ngrokc,\
	+PACKAGE_luci-app-ngrokc:ngrokc))



define Package/luci-app-kcptun/conffiles
/etc/config/kcptun
endef

$(eval $(call application,kcptun,LuCI Support for kcptun,\
	+PACKAGE_luci-app-kcptun:luci))



define Package/luci-app-qos_gargoyle/conffiles
/etc/config/qos_gargoyle
endef

define Package/luci-app-qos_gargoyle/postinst
#!/bin/sh 
[ -n "${IPKG_INSTROOT}" ] || {
	/etc/init.d/qos_gargoyle enable
	exit 0
}
endef 

$(eval $(call application,qos_gargoyle,LuCI Support for qos_gargoyle,\
	+PACKAGE_luci-app-qos_gargoyle:qos-gargoyle \
	+PACKAGE_luci-app-qos_gargoyle:gargoyle-firewall-util \
	+PACKAGE_luci-app-qos_gargoyle:libiptbwctl \
	+PACKAGE_luci-app-qos_gargoyle:libericstools))



define Package/luci-app-qos-guoguo/conffiles
/etc/config/qos_guoguo
endef

$(eval $(call application,qos-guoguo,LuCI Support for qos-guoguo,\
	+PACKAGE_luci-app-qos-guoguo:qos-guoguo))



define Package/luci-app-adkill/conffiles
/etc/config/adkill
endef

$(eval $(call application,adkill,LuCI Support for adkill,\
	+PACKAGE_luci-app-adkill:kmod-adkill))



$(eval $(call application,autossh,LuCI Support for autossh,\
	+PACKAGE_luci-app-autossh:autossh))



define Package/luci-app-redsocks2-alt/conffiles
/etc/config/redsocks2
endef

$(eval $(call application,redsocks2-alt,LuCI Support for redsocks2-alt,\
	+PACKAGE_luci-app-redsocks2-alt:redsocks2-alt))

define Package/luci-app-redsocks2-alt/postinst
#!/bin/sh
uci -q batch <<-EOF >/dev/null
	delete firewall.redsocks2
	set firewall.redsocks2=include
	set firewall.redsocks2.type=script
	set firewall.redsocks2.path=/usr/share/redsocks2/firewall.include
	set firewall.redsocks2.reload=1
	commit firewall
EOF
exit 0
endef




define Package/luci-app-chinadns/conffiles
/etc/config/chinadns
endef

define Package/luci-app-chinadns/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/luci-chinadns ) && rm -f /etc/uci-defaults/luci-chinadns
	chmod 755 /etc/init.d/chinadns >/dev/null 2>&1
	/etc/init.d/chinadns enable >/dev/null 2>&1
fi
exit 0
endef

$(eval $(call application,chinadns,LuCI Support for chinadns,\
	+PACKAGE_luci-app-chinadns:ChinaDNS))




define Package/luci-app-cdns/conffiles
/etc/config/cdns
endef

define Package/luci-app-cdns/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	chmod 755 /etc/init.d/cdns >/dev/null 2>&1
	/etc/init.d/cdns enable >/dev/null 2>&1
fi
exit 0
endef

$(eval $(call application,cdns,LuCI Support for CureDNS,\
	+PACKAGE_luci-app-cdns:cdns))



define Package/luci-app-vlmcsd/conffiles
/etc/config/vlmcsd
endef

$(eval $(call application,vlmcsd,LuCI Support for vlmcsd,\
	+PACKAGE_luci-app-vlmcsd:vlmcsd))


define Package/luci-app-vsftpd/conffiles
/etc/config/vsftpd
endef

$(eval $(call application,vsftpd,LuCI Support for vsftpd,\
	+PACKAGE_luci-app-vsftpd:vsftpd-alt))


define Package/luci-app-w8021x/conffiles
/etc/config/w8021x
endef

$(eval $(call application,w8021x,LuCI Support for w8021x,\
	+PACKAGE_luci-app-w8021x:w8021x))




define Package/luci-app-mentohust/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/luci-mentohust ) && rm -f /etc/uci-defaults/luci-mentohust
	chmod 755 /etc/init.d/mentohust >/dev/null 2>&1
   /etc/init.d/mentohust enable >/dev/null 2>&1
   rm -f /etc/mentohust.conf ; ln -s /tmp/mentohust.conf /etc/mentohust.conf
	exit 0
}
endef

define Package/luci-app-mentohust/postrm
#!/bin/sh
uci delete ucitrack.@mentohust[-1] >/dev/null 2>&1
uci commit ucitrack
exit 0
endef

define Package/luci-app-mentohust/conffiles
/etc/config/mentohust
endef

$(eval $(call application,mentohust,LuCI Support for MenToHUST,\
	+PACKAGE_luci-app-mentohust:mentohust))




define Package/luci-app-epg-oscam/conffiles
/etc/config/epg
/etc/config/oscam
endef

$(eval $(call application,epg-oscam,LuCI Support for epg-oscam,\
	+PACKAGE_luci-app-epg-oscam:oscam))




define Package/luci-app-nfsd/conffiles
/etc/config/nfsd
endef

$(eval $(call application,nfsd,LuCI Support for nfsd,\
	+PACKAGE_luci-app-nfsd:nfs-kernel-server))

define Package/luci-app-nfsd/postinst
#!/bin/sh
uci -q batch <<-EOF >/dev/null
	delete firewall.nfsd
	set firewall.nfsd=include
	set firewall.nfsd.type=script
	set firewall.nfsd.path=/usr/share/nfsd/firewall.include
	set firewall.nfsd.reload=1
	commit firewall
EOF
exit 0
endef



define Package/luci-app-n2n/conffiles
/etc/config/n2n
endef

$(eval $(call application,n2n,LuCI Support for n2n,\
	+PACKAGE_luci-app-n2n:n2n-edge \
	+PACKAGE_luci-app-n2n:n2n-supernode ))



define Package/luci-app-cpulimit/conffiles
/etc/config/cpulimit
endef

$(eval $(call application,cpulimit,LuCI Support for cpulimit,\
	+PACKAGE_luci-app-cpulimit:cpulimit-ng ))



define Package/luci-app-dns2socks/conffiles
/etc/config/dns2socks
endef

$(eval $(call application,dns2socks,LuCI Support for dns2socks,\
	+PACKAGE_luci-app-dns2socks:dns2socks ))




define Package/luci-app-syncdial/conffiles
/etc/config/syncdial
endef

$(eval $(call application,syncdial,LuCI Support for a diag hack,\
	+PACKAGE_luci-app-syncdial:luci-app-mwan3 \
	+PACKAGE_luci-app-syncdial:kmod-macvlan ))


$(eval $(call application,webshell,LuCI Support for webshell,\
	+PACKAGE_luci-app-webshell:luci))


$(eval $(call application,filetransfer,LuCI Support for filetransfer,\
	+PACKAGE_luci-app-filetransfer:luci \
	+PACKAGE_luci-app-filetransfer:luci-lib-fs))


define Package/luci-app-amule/conffiles
/etc/config/amule
/etc/amule/amule.conf.template
endef

$(eval $(call application,amule,LuCI Support for amule,\
	+PACKAGE_luci-app-amule:amule))




$(eval $(call application,cups,LuCI Support for cups,\
	+PACKAGE_luci-app-cups:cups))


define Package/luci-app-gmediarender/conffiles
/etc/config/gmediarender
endef

define Package/luci-app-gmediarender/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/luci-gmediarender ) && rm -f /etc/uci-defaults/luci-gmediarender
	chmod 755 /etc/init.d/gmediarender >/dev/null 2>&1
	/etc/init.d/gmediarender enable >/dev/null 2>&1
	exit 0
}
endef

$(eval $(call application,gmediarender,LuCI Support for gmediarender,\
	+PACKAGE_luci-app-gmediarender:gmediarender))





define Package/luci-app-syncy/conffiles
/etc/config/syncy
endef

$(eval $(call application,syncy,LuCI Support for syncy,\
	+PACKAGE_luci-app-syncy:kmod-nls-utf8 \
	+PACKAGE_luci-app-syncy:python-curl \
	+PACKAGE_luci-app-syncy:python-json \
	+PACKAGE_luci-app-syncy:python-openssl \
	+PACKAGE_luci-app-syncy:python-pyopenssl))




define Package/luci-app-rtorrent/conffiles
/etc/config/rtorrent
/etc/rtorrent/cookies.txt
/etc/rtorrent/rtorrent.rc.extra
endef

$(eval $(call application,rtorrent,LuCI Support for rtorrent,\
	+PACKAGE_luci-app-rtorrent:rtorrent-rpc \
	+PACKAGE_luci-app-rtorrent:dtach \
	+PACKAGE_luci-app-rtorrent:lua-bencode \
	+PACKAGE_luci-app-rtorrent:lua-xmlrpc \
	+PACKAGE_luci-app-rtorrent:luasocket \
	+PACKAGE_luci-app-rtorrent:lua-coxpcall \
	+PACKAGE_luci-app-rtorrent:lua-copas \
	+PACKAGE_luci-app-rtorrent:luaexpat))



$(eval $(call protocol,openvpn,OpenVPN protocol configuration,\
	+PACKAGE_luci-proto-openvpn:openvpn-client-netifd \
	+PACKAGE_luci-proto-openvpn:luci-lib-nixio))

$(eval $(call protocol,n2n,N2N protocol configuration,\
	+PACKAGE_luci-proto-n2n:n2n-edge))

$(eval $(call protocol,shadowvpn,ShadowVPN protocol configuration,\
	+PACKAGE_luci-proto-shadowvpn:shadowvpn))


define Package/luci-app-shadowsocksr-libev/conffiles
/etc/config/shadowsocksr-libev
endef

$(eval $(call application,shadowsocksr-libev,LuCI Support for shadowsocksr-libev,\
	+PACKAGE_luci-app-shadowsocksr-libev:shadowsocksr-libev ))


### Compile ###
PKG_CONFIG_DEPENDS=$(patsubst %,CONFIG_PACKAGE_%,$(LUCI_BUILD_PACKAGES))

include $(INCLUDE_DIR)/package.mk

define Build/Prepare
	@if [ ! -x $(LUCI_TOPDIR)/build/mkrevision.sh ]; then \
		echo "*** Repository layout changed!" >&2; \
		echo "*** Please change the LuCI url in feeds.conf to http://svn.luci.subsignal.org/luci/trunk and reinstall the feed with" >&2; \
		echo "*** ./scripts/feeds update luci; ./scripts/feeds install -a -p luci" >&2; \
		exit 1; \
	fi
	mkdir -p $(PKG_BUILD_DIR)
	$(TAR) c -C $(LUCI_TOPDIR) . \
		--exclude=.pc --exclude=.svn --exclude=.git \
		--exclude='boa-0*' --exclude='*.o' --exclude='*.so' \
		--exclude=dist | \
			tar x -C $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

MAKE_FLAGS += \
	MODULES="$(LUCI_SELECTED_MODULES)" \
	LUA_TARGET="$(LUA_TARGET)" \
	LUA_SHLIBS="-llua -lm -ldl -lcrypt" \
	CFLAGS="$(TARGET_CFLAGS) $(LUCI_CFLAGS) -I$(STAGING_DIR)/usr/include" \
	LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib" \
	NIXIO_TLS="$(NIXIO_TLS)" OS="Linux"


$(foreach b,$(LUCI_BUILD_PACKAGES),$(eval $(call BuildPackage,$(b))))
