# missnet-node/Makefile: OpenWrt metapackage for Metrix boxes on the Mississippi Network
# Copyright 2013 Personal Telco Project

include $(TOPDIR)/rules.mk

PKG_NAME:=missnet-node
PKG_VERSION:=0.3
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/missnet-node
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Metapackage for Personal Telco Mississippi Community Network devices
  URL:=https://personaltelco.net/wiki/OpenWrt
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= \
	+bridge \
	+curl \
	+diffutils \
	+dropbear \
	+horst \
	+iftop \
	+ip \
	+iw \
	+iwinfo \
	+kmod-ath5k \
	+kmod-batman-adv \
	+procps-ng \
	+rsync \
	+snmpd \
	+tcpdump \
	+wireless-tools \
	+wpad-mini
endef

define Package/missnet-node/config
	select BUSYBOX_CUSTOM
	select BUSYBOX_CONFIG_NTPD
	select BUSYBOX_CONFIG_MESG
	select BUSYBOX_CONFIG_RDATE
endef

define Package/missnet-node/description
Meta-configuration option which depends on all software which is
used in Mississippi Community Network installations.

Selecting this package will also select certain configuration options which
are needed to use the standard PTP settings.
endef

define Build/Compile
endef

define Build/Configure
endef

$(eval $(call BuildPackage,missnet-node))
