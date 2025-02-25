# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for Webrestriction From Koolshare
LUCI_DEPENDS:=+iptables-legacy +dnsmasq-full +ipset
LUCI_PKGARCH:=all
PKG_VERSION:=1.0
PKG_RELEASE:=5-20220406

include $(TOPDIR)/feeds/luci/luci.mk

# 添加自定义安装步骤
define Package/$(LUCI_NAME)/install
    # 安装LuCI核心文件
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci
    cp -pR $(LUCI_BUILD_DIR)/luasrc/* $(1)/usr/lib/lua/luci/
    
    # 安装init.d脚本（关键修复部分）
    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) ./files/etc/init.d/webrestriction $(1)/etc/init.d/webrestriction
    
    # 安装web文件
    $(INSTALL_DIR) $(1)/www/luci-static/resources/view
    cp -pR $(LUCI_BUILD_DIR)/htdocs/* $(1)/www/
endef

# 添加安装后处理（可选）
define Package/$(LUCI_NAME)/postinst
#!/bin/sh
[ -x "/etc/init.d/webrestriction" ] || \
    chmod +x "/etc/init.d/webrestriction"
exit 0
endef

# call BuildPackage - OpenWrt buildroot signature
