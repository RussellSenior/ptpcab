include $(TOPDIR)/rules.mk

PKG_NAME:=ptp-utils
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/ptp-utils
  SECTION:=ptp
  CATEGORY:=PTP
  TITLE:=Node utilities for Personal Telco devices
  URL:=https://personaltelco.net/wiki/OpenWrt
  MAINTAINER:=Russell Senior <russell@personaltelco.net>
endef

define Package/ptp-utils/description
endef

define Build/Compile
endef

define Build/Configure
endef

define Package/ptp-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/* $(1)/usr/bin/
endef

$(eval $(call BuildPackage,ptp-utils))
