include $(TOPDIR)/rules.mk

PKG_NAME:=qosmon-gargoyle
PKG_VERSION:=0.0.1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/qosmon-gargoyle
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A set of QoS scripts based on qos-gargoyle for Gargoyle Firmware
	DEPENDS:=+kmod-sched +iptables-mod-filter +iptables-mod-ipopt +iptables-mod-imq
	MAINTAINER:=GuoGuo <gch981213@gmail.com>
endef

define Package/qosmon-gargoyle/description
	qosmon from Gargoyle Firmware
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef


define Build/Configure
endef

define Build/Compile
	-$(MAKE) -C $(PKG_BUILD_DIR) clean
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -I $(STAGING_DIR)/usr/include" \
		LDFLAGS="$(TARGET_LDFLAGS) -L $(STAGING_DIR)/usr/lib" \
		BUILD_DIR="$(BUILD_DIR)" \
		all
endef

define Package/qosmon-gargoyle/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/qosmon $(1)/usr/sbin/qosmon

endef

$(eval $(call BuildPackage,qosmon-gargoyle))
