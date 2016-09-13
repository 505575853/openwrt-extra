#!/usr/bin/env lua
local socket = require 'socket'
local copas = require 'copas'
local uci = require "luci.model.uci".cursor()
local sys = require "luci.sys"

if uci:get("rtorrent", "main", "xmlrpc_bind_enable") ~= "1" then
    print("xmlrpc_bind_enable not set to 1")
    os.exit()
end

local config = {
    newhost=uci:get("rtorrent", "main", "xmlrpc_bind_host") or "0.0.0.0",
    newport=uci:get("rtorrent", "main", "xmlrpc_bind_port") or "5002",
    oldhost="127.0.0.1",
    oldport=uci:get("rtorrent", "main", "xmlrpc_port") or "5001",
}

print("Proxying from ".. config.newhost .. ":" .. config.newport
              .." to ".. config.oldhost .. ":" .. config.oldport)

local server = socket.bind(config.newhost,config.newport)

local headers_parsers = {
    [ "connection" ]= function(h)
        return "Connection: close"
    end,
    [ "host" ]= function(h)
        return "Host: " .. config.oldhost ..":"..config.oldport
    end,
    [ "location" ]= function(h)
        local  new, old ;
        if config.newport == "80" then new = config.newhost else new = config.newhost .. ":" .. config.newport end
        if config.oldport == "80" then old = config.oldhost else old = config.oldhost .. ":" .. config.oldport end
        return string.gsub(h,old,new,1);
    end
}

function get_method(l)
    return string.gsub(l,"^(%w+).*$","%1")
end

function parse_header(l)
    local head, last
    for k in string.gmatch(l,"([^:%s]+)%s?:") do head = string.lower(k) ; break end
    if headers_parsers[head] ~= nil then
        l =  headers_parsers[head](l)
    end
    if string.len(l) == 0 then last = true end
    return l .. "\r\n",last, l
end

function pass_headers_html(reader,writer)
    local len
    while true do
        local req = reader:receive()
        if req == nil then req = "" end
        if string.lower(string.sub(req,0,14)) == "content-length" then len = string.gsub(req,"[^:]+:%s*(%d+)","%1") end
        local header, last, h = parse_header(req)
        if last then break end
    end
        local respond_code = "HTTP/1.1 200 OK\r\n"
        local server_name = "Server: lua-copas/2.0.0\r\n"
	local content_type = "Content-Type: text/xml\r\n"
	local content_len = "Content-Length: " .. tonumber(len) .. "\r\n"
	local connection_type = "Connection: keep-alive\r\n\r\n"
	local header = respond_code .. server_name .. content_type .. content_len .. connection_type
        writer:send(header)
    return len
end

function pass_headers_scgi(reader,writer)
    local len
    while true do
        local req = reader:receive()
        if req == nil then req = "" end
        if string.lower(string.sub(req,0,14)) == "content-length" then len = string.gsub(req,"[^:]+:%s*(%d+)","%1") end
        local header, last, h = parse_header(req)
        if last then break end
    end
	local null = "\0"
	local content_length = "CONTENT_LENGTH" .. null .. tonumber(len) .. null
	local scgi_enable = "SCGI" .. null .. "1" .. null
	local request_method = "REQUEST_METHOD" .. null .. "POST" .. null
	local server_protocol = "SERVER_PROTOCOL" .. null .. "HTTP/1.1" .. null
	local header = content_length .. scgi_enable .. request_method .. server_protocol
        writer:send(string.len(header) .. ":" .. header .. ",")
    return len
end

function pass_body(reader,writer, len)
    if len == nil then
        while true do
            local res, err, part = reader:receive(512)
            if err == "closed" or err == 'timeout' then
                if part ~= nil then writer:send(part) end
                break
            end
            writer:send(res)
        end
    else
        if len == 0 then return nil end
        local res, err, part =  reader:receive(len)
        writer:send(res)
    end
end

function handler(sk8)
    local c = copas.wrap(sk8)
    local s = socket.connect(config.oldhost,config.oldport)
    if s == nil then 
        local pid_rtorrent = tonumber(luci.sys.exec("pidof rtorrent|awk '{print $1}'")) or 0
	if pid_rtorrent > 0 and not nixio.kill(pid_rtorrent, 0) then
		pid_rtorrent = 0
	end
        if pid_rtorrent == 0 then 
            print("rtorrent is not running")
            os.exit()
        end
    end
    s:settimeout(10)
    local len = pass_headers_scgi(c,s)
    if len ~= nil then pass_body(c,s,tonumber(len)) end
    local len2 = pass_headers_html(s,c)
    pass_body(s,c,len2)
    s:close()
end

copas.addserver(server, handler)
copas.loop()
