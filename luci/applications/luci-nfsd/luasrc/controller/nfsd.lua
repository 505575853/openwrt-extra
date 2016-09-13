--[[
 Nfsd Controller
]]--

module("luci.controller.nfsd", package.seeall)

function index()

	if not nixio.fs.access("/etc/config/nfsd") then
		return
	end
	entry({"admin", "nas"}, firstchild(), "NAS", 45).dependent = false
	entry({"admin", "nas", "nfsd"}, cbi("nfsd"), _("NFS Service"), 49).dependent = true

end
