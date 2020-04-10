local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_HanSeo_ScreenInfo")

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
	   TriggerClientEvent("HanSeo:init", source, user_id)
  end
end)


RegisterServerEvent("HanSeo_sv:ping")
AddEventHandler("HanSeo_sv:ping", function(CurrentPing)
local src = source
local CurrentPing = GetPlayerPing(src)
TriggerClientEvent("HanSeo_cl:ping", src, CurrentPing)
end)