vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
maxclients = GetConvarInt('sv_maxclients', 64)
fpscounter=math.floor(1.0/GetFrameTime())

fps=fpscounter
playerPing = 0
CurrentPing = 0

function printPing()
	ShowInfo(CurrentPing)
end

local function RGBRainbow( frequency )
    local result = {}
    local curtime = GetGameTimer() / 100

    result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
    result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
    result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )

    return result
end

RegisterNetEvent("HanSeo_cl:ping")
AddEventHandler("HanSeo_cl:ping", function(ping)
	CurrentPing = ping
end)

Citizen.CreateThread(function()
	while(true) do
		Citizen.Wait(200)
		TriggerServerEvent("HanSeo_sv:ping")
	end
end)

-- Ping CMD
RegisterCommand("ping", function(source, args, rawCommand)
	printPing()
end, false)

-- threads
-- fps thread
Citizen.CreateThread(function()
	while(true) do
		Citizen.Wait(200)
			local fpscounter = math.floor(1.0/GetFrameTime())
			fps=fpscounter
	end
end)

local own_id

RegisterNetEvent("HanSeo:init")
AddEventHandler("HanSeo:init", function(user_id)
	own_id = user_id
end)

Citizen.CreateThread(function(SetData)
    while true do
		local ID = GetPlayerServerId(PlayerId())
		local name = GetPlayerName(PlayerId())
		players = {}
			for i = 0, 256 do -- make it compatible with OneSync
				if NetworkIsPlayerActive( i ) then
				table.insert( players, i )
				end
			end
	Citizen.Wait(0)
	    local player = GetPlayerPed(-1)
        local position = GetEntityCoords(player)
		local vehicle = GetVehiclePedIsIn(player, false)
				DrawTxt(0.14, 1.116, 0.27, 0.27, 0.2,"~w~Made By HanSeo#7777", 255,255,255,255)
				
			if own_id ~= nil then
				DrawTxt(0.15, 0.794, 0.27, 0.27, 0.27,"~w~닉네임 : ~g~".. name .."~w~", 255,255,255,255)
				DrawTxt(0.15, 0.812, 0.27, 0.27, 0.27,"~w~고유 번호 : ~y~"..own_id.."번", 255,255,255,255)
			end
				DrawTxt(0.15, 0.830, 0.27, 0.27, 0.27,"~w~온라인 플레이어 : ~g~"..#players.."~w~ 명", 255,255,255,255)
				DrawTxt(0.15, 0.758, 0.27, 0.27, 0.27,"~w~핑 : ~b~"..CurrentPing .. "ms", 255,255,255,255)
			if fps > 0 and fps < 12 then
				DrawTxt(0.15, 0.776, 0.27, 0.27, 0.27,"~w~FPS : ~r~"..fps .. "~w~ 프레임", 255,255,255,255)
			elseif fps > 0 and fps < 30 then
				DrawTxt(0.15, 0.776, 0.27, 0.27, 0.27,"~w~FPS : ~o~"..fps .. "~w~ 프레임", 255,255,255,255)
			elseif fps > 0 and fps < 1000 then
				DrawTxt(0.15, 0.776, 0.27, 0.27, 0.27,"~w~FPS : ~g~"..fps .. "~w~ 프레임", 255,255,255,255)
			else
				if fps > 0 and fps < 1000 then
					DrawTxt(0.15, 0.776, 0.27, 0.27, 0.27,"~w~FPS : "..fps .. "~w~ 프레임", 255,255,255,255)
				end
			end
	end
end)

Citizen.CreateThread( function()
	while true do
		Wait(0)
        SetTextFont(1)
		SetTextScale(0.2, 0.2)
		local rgb = RGBRainbow(1)
		SetTextColour(rgb.r, rgb.g, rgb.b, 255)
		SetTextOutline()
		SetTextEntry("STRING")
        AddTextComponentString("한서 샵# 디스코드 링크")
        DrawText(0.001,0.001)
	end
end)

Citizen.CreateThread( function()
	while true do
		Wait(0)
        SetTextFont(1)
		SetTextScale(0.185, 0.185)
		local rgb = RGBRainbow(1)
		SetTextColour(rgb.r, rgb.g, rgb.b, 255)
		SetTextOutline()
		SetTextEntry("STRING")
        AddTextComponentString("https://discord.gg/7Rj8WvP")
        DrawText(0.001,0.013)
	end
end)



function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, false)
end

function PrintText(text)
	SetTextEntry("STRING")
end

function DrawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end