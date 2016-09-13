module("luci.controller.redsocks2",package.seeall)
function index()
local e
e=node("admin","RA-MOD")
e.target=firstchild()
e.title=_("RA-MOD")
e.order=65
e=entry({"admin","network","redsocks2"},cbi("redsocks2"),_("Redsocks2"),50)
e.i18n="redsocks2"
e.dependent=true
end
