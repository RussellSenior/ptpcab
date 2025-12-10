# dumb-ap/Makefile: OpenWrt metapackage for dumb-ap devices
# Copyright 2013 Personal Telco Project

include $(TOPDIR)/rules.mk

PKG_NAME:=dumb-ap
PKG_VERSION:=0.3
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/dumb-ap
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Metapackage for Personal Telco dumb AP devices
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
	+kmod-batman-adv \
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
	+rsync \
	+snmpd \
	+tcpdump \
	+wpad-basic-mbedtls
endef

define Package/dumb-ap/config
	select BUSYBOX_CUSTOM
	select BUSYBOX_CONFIG_NTPD
	select BUSYBOX_CONFIG_MESG
	select BUSYBOX_CONFIG_RDATE
endef

define Package/dumb-ap/description
Meta-configuration option which depends on all software which is
used in dumb access point installations, i.e. access points hanging 
off of networks gatewayed by other devices in multi-AP configurations.

Selecting this package will also select certain configuration options which
are needed to use the standard PTP settings.
endef

define Package/dumb-ap-ath5k
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Node metapackage for dumb ap devices with ath5k-supported radio
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= \
	+dumb-ap \
	+kmod-ath5k
endef

define Package/dumb-ap-ath9k
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Node metapackage for dumb ap devices with ath5k-supported radio
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
  DEPENDS:= \
	+dumb-ap \
	+kmod-ath9k
endef

define Build/Compile
endef

define Build/Configure
endef



$(eval $(call BuildPackage,dumb-ap))
$(eval $(call BuildPackage,dumb-ap-ath5k))
$(eval $(call BuildPackage,dumb-ap-ath9k))
