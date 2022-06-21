local ESX = exports['es_extended']:getSharedObject()
local CopsConnected = 0

function CountCops()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end
	SetTimeout(15000, CountCops)
end
CountCops()

local function parse_time(str)
	local hour, min = str:match("(%d+):(%d+)")
	if hour == '00' then
		hour = 0
	end
	if min == '00' then
		min = 0
	end
	return os.time{hour = hour, min = min,sec = 1, day = 1, month = 1, year = 1971}
end

local function BetweenTimes(between,start,stop)
	between = parse_time(between)
	start = parse_time(start)
	stop = parse_time(stop)
	if stop < start then
		stop = stop + 24*60*60
	end
	return (start <= between) and (between <= stop)
end

RegisterServerEvent('falkon_droghe:raccolta')
AddEventHandler('falkon_droghe:raccolta', function(Raccolta)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and Raccolta then
        if not BetweenTimes(os.date('%H:%M'), Config.BlockRaccoltaFrom, Config.BlockRaccoltaTo) or Raccolta.libera then
            if CopsConnected >= Raccolta.polizia then
                if xPlayer.job.name ~= 'police' and xPlayer.job.name ~= 'ambulance' then
                    xPlayer.addInventoryItem(Raccolta.item, 5)
                    xPlayer.showNotification('Hai raccolto 5x di '..ESX.GetItemLabel(Raccolta.item)..'')
                else
                    xPlayer.showNotification('Non puoi raccogliere!', 'warning')
                end
            else
                xPlayer.showNotification('Non c\'e abbastanza polizia')
            end
        else
            xPlayer.showNotification('Non puoi raccogliere!')
        end
    end
end)

RegisterServerEvent('falkon_droghe:processo')
AddEventHandler('falkon_droghe:processo', function(Processo)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and Processo then
        local itemCount = xPlayer.getInventoryItem(Processo.item).count
        if itemCount > 0 then
            if not BetweenTimes(os.date('%H:%M'), Config.BlockProcessamentoFrom, Config.BlockProcessamentoTo) or Processo.libera then
                if CopsConnected >= Processo.polizia then
                    if xPlayer.job.name ~= 'police' and xPlayer.job.name ~= 'ambulance' then
                        xPlayer.removeInventoryItem(Processo.item, 2)
                        xPlayer.addInventoryItem(Processo.item2, 1)
                        xPlayer.showNotification('Hai processato 1x di '..ESX.GetItemLabel(Processo.item)..' in '..ESX.GetItemLabel(Processo.item2)..'')
                    else
                        xPlayer.showNotification('Non puoi processare!', 'warning')
                    end
                else
                    xPlayer.showNotification('Non c\'e abbastanza polizia')
                end
            else
                xPlayer.showNotification('Non puoi raccogliere!')
            end
        else
            xPlayer.showNotification('Non hai abbastanza materia')
        end
    end
end)

RegisterServerEvent('falkon_droghe:vendita')
AddEventHandler('falkon_droghe:vendita', function(Vendita)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and Vendita then
        local inveCount = xPlayer.getInventoryItem(Vendita.item).count
        if inveCount and inveCount > 0 then
            if CopsConnected >= Vendita.polizia then
                local prezzo = (tonumber(Vendita.prezzo)*tonumber(inveCount))
                if xPlayer.job.name ~= 'police' and xPlayer.job.name ~= 'ambulance' then
                    xPlayer.removeInventoryItem(Vendita.item, inveCount)
                    xPlayer.addAccountMoney('black_money', prezzo)
                    xPlayer.showNotification('Hai venduto '..inveCount..'x di '..ESX.GetItemLabel(Vendita.item)..' per '..math.floor(prezzo)..'')
                else
                    xPlayer.showNotification('Non puoi processare!', 'warning')
                end
            else
                xPlayer.showNotification('Non c\'e abbastanza polizia')
            end
        else
            xPlayer.showNotification('Non hai abbastanza '..ESX.GetItemLabel(Vendita.item)..'')
        end
    end
end)

AddEventHandler('esx:playerLoaded',function(_, xPlayer)
    if xPlayer then
        xPlayer.triggerEvent('falkon_droghe:pconfig', Config)
    end
end)