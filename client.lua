-- By Lauren.
-- Coded for Lauren Development discord server.

local QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)


RegisterNetEvent('aracsatma:client')
AddEventHandler('aracsatma:client', function(kisi,karsi,plaka)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    local sofor = GetPedInVehicleSeat(veh, -1)
    local plate = GetVehicleNumberPlateText(veh)
    local model = veh
    local Player, Distance = QBCore.Functions.GetClosestPlayer()
	if veh then
		if plaka == plate then
			if sofor == ped then
				  if Player ~= -1 and Distance < 5 and GetPlayerServerId(Player) == karsi.PlayerData.source then  
					TriggerServerEvent("aracsatma:server",kisi,karsi,plate,model)
				else
					QBCore.Functions.Notify('Kişi yakınında olmalı!', 'error')
				end
			else	
				QBCore.Functions.Notify('Şöför koltuğunda olman gerekir!', 'error')
			end
		else
			QBCore.Functions.Notify('Plaka bulunamadı!', 'error')
		end
	else	
		QBCore.Functions.Notify('Araçta olman gerekiyor!', 'error')
	end
end)
