--[[
 Copyright (C) 2016 maz-1 <ohmygod19993@gmail.com>

 This is free software, licensed under the GNU General Public License v3.
 See /LICENSE for more information.
]]--

m = Map("autossh", translate("AutoSSH"),
	translate("SSH Reverse Tunnel"))

s = m:section(TypedSection, "autossh", translate("AutoSSH Settings"))
s.anonymous   = true
s.addremove   = false

o = s:option(Flag, "enabled", translate("Enable"))
o.rmempty = false

function o.cfgvalue(self, section)
	return luci.sys.init.enabled("autossh") and self.enabled or self.disabled
end

function o.write(self, section, value)
	if value == "1" then
		luci.sys.init.enable("autossh")
		luci.sys.call("/etc/init.d/autossh start >/dev/null")
	else
		luci.sys.call("/etc/init.d/autossh stop >/dev/null")
		luci.sys.init.disable("autossh")
	end

	return Flag.write(self, section, value)
end

o = s:option(Value, "ssh", translate("SSH Params"))
o.rmempty     = false

o = s:option(Value, "gatetime", translate("Gate Time"))
o.placeholder = 0
o.default     = 0
o.datatype    = "uinteger"

o = s:option(Value, "monitorport", translate("Monitor Port"))
o.datatype    = "port"
o.rmempty     = false

o = s:option(Value, "poll", translate("Poll Time"))
o.placeholder = 600
o.default     = 600
o.datatype    = "uinteger"

return m
