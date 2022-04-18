-- By Lauren.
-- Coded for Lauren Development discord server.

local QBCore = nil 

TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)  
------ARAÇ SATMA ----------

QBCore.Commands.Add("aracsat", "Araç Satma", {{name="id", help="Oyuncu ID"},  {name="plaka", help="Plaka"}}, false, function(source, args)
	if (args[1] ~= nil or args[2] ~= nil ) then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1])) -- oyuncu id
		local plaka = args[2] -- plaka
		if Player ~= nil then
			if Player.PlayerData.source ~= source then
				TriggerClientEvent('aracsatma:client', source, source, Player, plaka)
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Kendine satamazsın!")
			end
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Kişi bulunamadı!")
		end
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Kişi ID veya Plakayı doğru yazdığından emin ol!")
	end
end)

--EVENT
RegisterNetEvent("aracsatma:server")
AddEventHandler("aracsatma:server", function(source,karsi,plate,model)
    local src = source
    local target = karsi.PlayerData.source
    local Player = QBCore.Functions.GetPlayer(src)
    local tCid = karsi.PlayerData.citizenid
    local isim = karsi.PlayerData.charinfo.firstname.." "..karsi.PlayerData.charinfo.lastname -- karşı oyuncu ismi
    local ismim = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname -- kendi  ismi
	QBCore.Functions.ExecuteSql(false, "SELECT * FROM `characters_vehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
			if result[1].citizenid	== Player.PlayerData.citizenid then		
				TriggerClientEvent("QBCore:Notify", src,"Aracı başarıyla "..isim.." isimli kişiye sattınız!","success") -- satan kişiye gelen bildirim
				TriggerClientEvent("QBCore:Notify", target,""..ismim.." isimli kişi size "..plate.." Plakalı aracı sattı!","success") -- alan kişiye gelen bildirim
				QBCore.Functions.ExecuteSql(true, "UPDATE `characters_vehicles` SET citizenid='"..tCid.."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `plate` = '"..plate.."'")
			else	
				TriggerClientEvent("QBCore:Notify", src,"Bu aracın sahibi siz değilsiniz!","error") --araç sahibi değilse
			end
		else
			TriggerClientEvent("QBCore:Notify", src,"Böyle bir plakalı araca sahip değilsin!","error")
		end
	end)
end)
