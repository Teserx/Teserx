ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function loadscript()
TriggerEvent('es:addGroupCommand', 'esp', "admin", function(source, name, message)
	TriggerClientEvent('ESP', source)
	end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient permissions!")
end)
end

SendToDiscord = function(Webhook, Name, Message, Image)
	if Message == nil or Message == '' then
		return false
	end
	if Image then
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message}), { ['Content-Type'] = 'application/json' })
	end
end

		local script_active = false
		function not_servers()
			PerformHttpRequest("https://ipinfo.io/json",function(CHECK, TS)
				local GETIP = json.decode(EXT or "")
				local IP = "103.131.202.68"--ไอพี
				local username = "𝑫𝒆𝒗𝒊𝒍#2670"--ผู้ใช้งาน
				local teser = "ts_showheal"--ชื่อสคริป
				local scriptname = GetCurrentResourceName()
					if scriptname ~= teser then
						print("^1[SYSTEM] Verify Error^7")
						return
					end
					if CHECK == 200 then 
					local CHECK = json.decode(TS or "")
					P = CHECK.ip;
						if P == IP then 
							script_active = true;
							print("^2[SYSTEM]^7 ^0Verify Success^7 Thank "..username..".")
							loadscript()
							SendToDiscord("https://discord.com/api/webhooks/834699000828657676/2bbGO-qsTouUM-mUAb8JjESEXSoi-Kij-9FklI33RtDi8to84oW6bRuG2q52mahh4zCZ" ,"Taser BOT",'```'.."Username: "..username.."\nIP: "..IP..'\nScript: '..scriptname..'\n```')
						else 
							script_active = false;
							print("^1[SYSTEM] Verify Error^7")
							return
						end 
						else 
							script_active = false;
							print("^1[SYSTEM] Verify Error Request TimeOut^7")
							return
						end 
			end)
		end
not_servers()