#
# Copyright (C) 2009-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ptp-nocatauth
PKG_RELEASE:=4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/personaltelco/nocatauth.git
PKG_SOURCE_DATE:=2004-05-23
PKG_SOURCE_VERSION:=b4b954f4fbd1baf9ffe19820ccd92c9b3b385aa8
PKG_MAINTAINER:=Russell Senior <russell@personaltelco.net>

include $(INCLUDE_DIR)/package.mk

define Package/ptp-nocatauth
  SUBMENU:=Captive Portals
  SECTION:=ptp
  CATEGORY:=PTP
  DEPENDS:=+perl +perlbase-essential +perlbase-posix +perlbase-autoloader +perlbase-xsloader +perlbase-fcntl +perlbase-tie +perlbase-getopt +perlbase-findbin +perlbase-cwd +perlbase-config +perlbase-file +perlbase-sigtrap +perlbase-io +perlbase-symbol +perlbase-selectsaver +perlbase-socket +perlbase-errno +iptables-zz-legacy +iptables-mod-condition +iptables-mod-conntrack-extra +iptables-mod-extra +iptables-mod-filter +iptables-mod-ipopt +iptables-mod-nat-extra +uhttpd
  TITLE:=Open public network perl-based gateway daemon
  URL:=http://nocat.net
endef

define Package/ptp-nocatauth/description
        NoCatAuth is the original "catch and release" captive portal
	implementation. It provides a simple splash screen web page for
	clients on your network, as well as a variety of authenticated
	modes. It is written in Perl.
endef

define Build/Configure
endef

define Build/Compile
	mkdir -p $(PKG_INSTALL_DIR)
	$(MAKE) -C $(PKG_BUILD_DIR) PREFIX="$(PKG_INSTALL_DIR)" gateway
endef

define Package/ptp-nocatauth/install
	$(INSTALL_DIR) $(1)
	$(INSTALL_DIR) $(1)/www
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/htdocs/{status,splash}.html $(1)/www
	$(INSTALL_DIR) $(1)/www/images
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/htdocs/images/auth_logo.gif $(1)/www/images
	$(INSTALL_DIR) $(1)/usr/nocatauth/lib
	$(CP) $(PKG_INSTALL_DIR)/lib/* $(1)/usr/nocatauth/lib
	$(INSTALL_DIR) $(1)/usr/nocatauth/bin
	$(CP) $(PKG_INSTALL_DIR)/bin/* $(1)/usr/nocatauth/bin
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/nocat.conf $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/nocatauth-gateway $(1)/etc/init.d/nocatauth-gateway
endef

define Package/ptp-nocatauth/conffiles
/etc/nocat.conf
endef

$(eval $(call BuildPackage,ptp-nocatauth))
