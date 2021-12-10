local Framework = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if Framework == nil then
            TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
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
  local Player, Distance = Framework.Functions.GetClosestPlayer()
	if veh then
		if plaka == plate then
			if sofor == ped then
				  if Player ~= -1 and Distance < 5 and GetPlayerServerId(Player) == karsi.PlayerData.source then  
					TriggerServerEvent("aracsatma:server",kisi,karsi,plate,model)
				else
					Framework.Functions.Notify('Kişi yakınında olmalı!', 'error')
				end
				else	
					Framework.Functions.Notify('Şöför koltuğunda olman gerekir!', 'error')
				end
			else
				Framework.Functions.Notify('Plaka bulunamadı!', 'error')
		end
			else	
				Framework.Functions.Notify('Araçta olman gerekiyor!', 'error')
	end
end)