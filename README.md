OpenWrt-Extra
=============

Some extra packages for OpenWrt

Add "src-git extra git://github.com/openwrt-stuff/openwrt-extra.git" to feeds.conf.default.

```bash
./scripts/feeds update -a
./scripts/feeds install -a
```

Some of the packages:
* luci-app-adkill
* luci-app-amule
* luci-app-cpulimit
* luci-app-ngrokc
* luci-app-qos-guoguo (requires some patches : https://github.com/openwrt-stuff/openwrt-mod/tree/generic/patches/02_imq)
* luci-app_samba4 
* luci-app-rtorrent
* luci-app-shadowsocks-libev-obfs
* uPD72020x-firmware
* ufsd (only available to specific architectures and kernel versions)
