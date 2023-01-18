# ptp-node/Makefile: OpenWrt metapackage for PTP node devices
# Copyright 2012 Personal Telco Project

include $(TOPDIR)/rules.mk

PKG_NAME:=ptp-node
PKG_VERSION:=0.3
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/ptp-node
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Metapackage for Personal Telco node devices
  URL:=https://personaltelco.net/wiki/OpenWrt
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= \
	+bridge \
	+curl \
	+diffutils \
	+dnsmasq \
	+dropbear \
	+iftop \
	+ip-tiny \
	+iptables-mod-filter \
	+iptables-mod-condition \
	+iptables-mod-conntrack-extra \
	+iptables-mod-extra \
	+ncat \
	+odhcpd-ipv6only \
	+odhcp6c \
	+olsrd \
	+olsrd-mod-txtinfo \
	+openvpn-mbedtls \
	+procps-ng \
	+procps-ng-free \
	+procps-ng-kill \
	+procps-ng-pgrep \
	+procps-ng-pkill \
	+procps-ng-pmap \
	+procps-ng-ps \
	+procps-ng-pwdx \
	+procps-ng-skill \
	+procps-ng-slabtop \
	+procps-ng-snice \
	+procps-ng-tload \
	+procps-ng-top \
	+procps-ng-uptime \
	+procps-ng-vmstat \
	+procps-ng-w \
	+procps-ng-watch \
	+ptp-utils \
	+rsync \
	+snmpd \
	+tcpdump
endef

define Package/ptp-node/config
	select BUSYBOX_CUSTOM
	select BUSYBOX_CONFIG_NTPD
	select BUSYBOX_CONFIG_MESG
	select BUSYBOX_CONFIG_RDATE
endef

define Package/ptp-node/description
Meta-configuration option which depends on all software which is
used in common Personal Telco Project node installations.

Selecting this package will also select certain configuration options which
are needed to use the standard PTP settings.
endef

define Package/ptp-node-with-ath5k
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Node metapackage for adding ath5k to Personal Telco devices
  URL:=https://personaltelco.net/wiki/OpenWrt
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= +ptp-node \
	+iw \
	+iwinfo \
	+kmod-ath5k \
	+wpad-basic-mbedtls
endef

define Package/ptp-node-with-ath5k/description
Adds ath5k wireless and tools to standard PTP node
endef

define Package/ptp-node-with-ath9k
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Node metapackage for adding ath9k to Personal Telco devices
  URL:=https://personaltelco.net/wiki/OpenWrt
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= +ptp-node \
	+iw \
	+iwinfo \
	+kmod-ath9k \
	+wpad-basic-mbedtls
endef

define Package/ptp-node-with-ath9k/description
Adds ath9k wireless and tools to standard PTP node
endef

define Package/ptp-node-with-usbnet
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Node metapackage for adding usbnet to Personal Telco devices
  URL:=https://personaltelco.net/wiki/OpenWrt
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= +ptp-node \
	+kmod-usb-net \
	+kmod-usb-net-cdc-ether \
	+kmod-usb-net-rndis
endef

define Package/ptp-node-with-usbnet/description
Adds usbnet (to allow, for example, tethering to cellphones) to standard PTP node
endef

define Build/Compile
endef

define Build/Configure
endef

$(eval $(call BuildPackage,ptp-node))
$(eval $(call BuildPackage,ptp-node-with-ath5k))
$(eval $(call BuildPackage,ptp-node-with-ath9k))
$(eval $(call BuildPackage,ptp-node-with-usbnet))
