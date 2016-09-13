-- Copyright 2015 Jian Chang <aa65535@live.com>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.shadowsocksr-libev", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/shadowsocksr-libev") then
		return
	end

	page = entry({"admin", "services", "shadowsocksr-libev"}, cbi("shadowsocksr-libev"), _("ShadowSocksR-libev"), 74)
        page.dependent = true
	page.i18n = "shadowsocksr-libev"
end
