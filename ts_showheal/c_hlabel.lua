
local disPlayerNames = 0
local playerSource = 0
local ESPON = false
local PlayersTag    = {}
local PlayersTagV    = {}

RegisterFontFile("MitrLight")
fontId = RegisterFontId("MitrLight")

RegisterNetEvent('ESP')
AddEventHandler('ESP', function()
	if ESPON == false then
		disPlayerNames = 100
		--print('esp on')
		ESPON = true
	else
		disPlayerNames = 0
		--print('esp off')
		ESPON = false
	end
end)

RegisterNetEvent('hlrangef')
AddEventHandler('hlrangef', function()
	disPlayerNames = 100
end)

RegisterNetEvent('Artysettag')
AddEventHandler('Artysettag', function(tag)
	PlayersTag = tag
	--print(json.encode(PlayersTag))
end)

RegisterNetEvent('vipz')
AddEventHandler('vipz', function(tagv)
	PlayersTagV = tagv
	--print(json.encode(PlayersTag))
end)


local defaultColor = {r = 245, g = 245, b = 245, a = 255}

local armorColor = {r = 50, g = 170, b = 250, a = 200}

local bgColor = {r = 0, g = 0, b = 0, a = 100}


Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)

	end

	while true do


		local closep 		= false

		local MyCamCoords	= GetGameplayCamCoords()

		local localFPS = 1 / GetFrameTime()

		local localPl = PlayerId()


		local Freeaim, AimedAtEntity = GetEntityPlayerIsFreeAimingAt(localPl)

		for _, id in ipairs(GetActivePlayers()) do

			if id ~= localPl then

				local playerHead = GetPedBoneCoords(ped, 12844, 0, 0, 0) + vector3(0, 0, 0.7) + (GetEntityVelocity(ped) / localFPS)

				local distance = math.floor(#(MyCamCoords - playerHead))

				if distance < disPlayerNames and World3dToScreen2d(playerHead.x, playerHead.y, playerHead.z) then

					closep = true

					-- local t 		= (GetPlayerTag(id) and ""..GetPlayerTag(id).."" or "")

					-- local vip 		= GetPlayerTagV(id)

					local talking	= NetworkIsPlayerTalking(id)


					SetDrawOrigin(playerHead, false)


					local sizeOffset = math.max(1 - distance / 20, 0.5)

					SetTextFont(fontId)

						local ped 	= GetPlayerPed(id)
						
						local Health	= GetEntityHealth(ped)
						
						local healthPercent = math.min(math.max((Health - 100) / 100, 0.0), 1.0)

						local Armor		= GetPedArmour(ped)

						local armorPercent = math.min(math.max(Armor / 100, 0.0), 1.0)

						local armorBar = ESX.Math.Round(200 * armorPercent) * sizeOffset

						local line = 2
						
						if talking then

							line = line +1

						end
						
					SetTextScale(0.0, 0.4*sizeOffset)

					SetTextCentre(true)

					SetTextOutline()

					SetTextEntry("STRING")

					AddTextComponentString((talking and "~n~👄" or "" ))

					DrawText(0.0, 0.0)

						GTAN_DrawRectangle(-75 * sizeOffset, 40 * (sizeOffset * line), armorBar, 28 * sizeOffset, armorColor.r  , armorColor.g, armorColor.b, armorColor.a)

						GTAN_DrawRectangle(-71 * sizeOffset, (44 - (line)) * (sizeOffset * line), 200 * healthPercent * sizeOffset, 20 * sizeOffset, 250, 50, 50, 200)
						
						--print(Health)

					DrawText(0.0, 0.0)

					ClearDrawOrigin()

				end

			end

		end

		if not closep then

			Citizen.Wait(1000)

		end

		Citizen.Wait(0)

	end

end)

function GTAN_DrawRectangle(xPos, yPos, wSize, hSize, r, g, b, alpha)
	local _width, _height = GetScreenActiveResolution()

	local ratio = _width / _height

	local width = _height * ratio
	
	local w = wSize / width

	local h = hSize / _height

	local x = (xPos / width) + w * 0.5

	local y = (yPos / _height) + h * 0.5

	DrawRect(x, y, w, h, r, g, b, alpha)

end
