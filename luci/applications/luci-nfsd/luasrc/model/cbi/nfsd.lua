
m = Map("nfsd", translate("NFS server"), translate("Secure and fastest NFS server"))

s = m:section(TypedSection, "nfsd", translate("General"))
s.anonymous = true

switch = s:option(Flag, "enable", translate("enable"), translate("Enable NFS Sevice"))
switch.rmempty = false


s = m:section(TypedSection, "nfsshare", translate("NFS shares"))
s.template  = "cbi/tblsection"
s.anonymous = true
s.addremove = true

u = s:option(Flag, "enable", translate("Enable"))
u.rmempty = false
u.disabled = 0

s:option(Value, "name", translate("Name"))

i = s:option(Value, "iprange", translate("Allowed IPs"))
i.placeholder = "*"
i.rmempty = true

o = s:option(Value, "options", translate("Options"))
o.placeholder = "ro,all_squash,insecure,sync"
o.rmempty = false

upth = s:option(Value, "path", translate("Path"))
upth.rmempty = false
upth.datatype = "directory"

--[[local upth_suggestions = nixio.fs.glob("/mnt/sd*")

if upth_suggestions then
	local node
	for node in upth_suggestions do
		upth:value(node)
	end
end
   ]]--
if nixio.fs.access("/etc/config/fstab") then
	upth.titleref = luci.dispatcher.build_url("admin", "system", "fstab")
	local command = "uci show fstab|grep -E \"\\.target\\=\"|grep -oE \"/[^\\'\\\"]*\"|sed ':a;N;$!ba;s/\\n/:/g'"
	local upth_suggestions = luci.sys.exec(command)

	if upth_suggestions then
		for entry in string.gmatch(upth_suggestions, "[^:]+") do
			upth:value(entry)
		end
	end
end

return m

