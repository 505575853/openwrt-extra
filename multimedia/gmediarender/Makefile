#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gmediarender
PKG_VERSION:=2017-08-03
PKG_RELEASE=3.9.4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/hzeller/gmrender-resurrect.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=3185dfc2e024eea80f5545eccdcbbf13afc56dc1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)

PKG_FIXUP:=autoreconf
PKG_INSTALL=1
PKG_REMOVE_FILES:=autogen.sh aclocal.m4

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/gmediarender
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:= +glib2 +libupnp +libgstreamer1 
#+libgst1check +libgst1controller +libgst1net \
#	+gst1-mod-alsa +gst1-mod-app +gst1-mod-autodetect +gst1-mod-audioconvert \
#	+gst1-mod-audiorate +gst1-mod-audioresample +gst1-mod-audiotestsrc \
#	+gst1-mod-icydemux +gst1-mod-id3demux +gst1-mod-mad +gst1-mod-ogg +gst1-mod-flac \
#	+gst1-mod-faad +gst1-mod-souphttpsrc +gst1-mod-tcp +gst1-mod-wavparse +gst1-mod-volume
	# +gst1-mod-playback \
	
  TITLE:=A Headless UPnP Renderer
endef

define Package/gmediarender/description
  (Yeso MODE)gmediarender implements the server component that provides UPnP
  controllers a means to render media content (audio, video and images)
  from a UPnP media server.
endef

#define Build/Prepare
#	mkdir -p $(PKG_BUILD_DIR)
#	$(CP) ./gmediarender/* $(PKG_BUILD_DIR)/
#endef

CONFIGURE_ARGS+= \
	--with-build-cc="$(HOSTCC)" \
	--prefix="\usr"

define Package/gmediarender/install
	$(INSTALL_DIR) 	$(1)/usr/sbin
	$(INSTALL_BIN) 	$(PKG_INSTALL_DIR)/usr/bin/$(PKG_NAME) $(1)/usr/sbin/
#	$(INSTALL_DIR) 	$(1)/etc/init.d
#	$(CP) 		$(PKG_BUILD_DIR)/scripts/init.d/$(PKG_NAME)er $(1)/etc/init.d/$(PKG_NAME)
	$(INSTALL_DIR) 	$(1)/usr/share/gmediarender/
	$(CP) 		$(PKG_BUILD_DIR)/data/grender-64x64.png $(1)/usr/share/gmediarender/
	$(CP) 		$(PKG_BUILD_DIR)/data/grender-128x128.png $(1)/usr/share/gmediarender/
endef

$(eval $(call BuildPackage,gmediarender))
