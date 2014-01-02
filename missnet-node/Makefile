# missnet-node/Makefile: OpenWrt metapackage for PTP nodes
# Copyright 2013 Personal Telco Project

include $(TOPDIR)/rules.mk

PKG_NAME:=missnet-node
PKG_VERSION:=0.3
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/missnet-node
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Node metapackage for Personal Telco Mississippi Community Network devices
  URL:=https://personaltelco.net/wiki/OpenWrt
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= \
	+bridge \
	+crda \
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
	+kmod-bridge \
	+procps \
	+rsync \
	+snmpd \
	+tcpdump \
	+traceroute6 \
	+wget \
	+wireless-tools \
	+wpad-mini \
	@!PACKAGE_ppp \
	@!PACKAGE_firewall
endef

define Package/missnet-node/config
	select BUSYBOX_CONFIG_NTPD
	select BUSYBOX_CONFIG_MESG
	select BUSYBOX_CONFIG_PKILL
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
