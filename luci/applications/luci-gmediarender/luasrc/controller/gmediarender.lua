--[[
LuCI - Lua Configuration Interface
]]--

module("luci.controller.gmediarender", package.seeall)

function index()

	if not nixio.fs.access("/etc/config/gmediarender") then
		return
	end

	entry({"admin", "nas"}, firstchild(), "NAS", 45).dependent = false
	local page
	page = entry({"admin", "nas", "gmediarender"}, cbi("gmediarender"), _("gmediarender"))
	page.i18n = "gmediarender"
	page.dependent = true
end
