# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for Webrestriction From Koolshare
LUCI_PKGARCH:=all
PKG_VERSION:=1.0
PKG_RELEASE:=5-20220406

include $(TOPDIR)/feeds/luci/luci.mk
# 添加安装后处理（可选）
define Package/$(LUCI_NAME)/postinst
#!/bin/sh
[ -x "/etc/init.d/webrestriction" ] || \
    chmod +x "/etc/init.d/webrestriction"
exit 0
endef

# call BuildPackage - OpenWrt buildroot signature
