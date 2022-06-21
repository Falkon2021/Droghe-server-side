local ESX = exports.es_extended:getSharedObject()
local raccogliendo = false

RegisterNetEvent('falkon_droghe:pconfig')
AddEventHandler('falkon_droghe:pconfig',function(config)
    CreaBlips(config)
end)

function CreaBlips(Config)
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        for k, v in pairs(Config.Droga) do
            TriggerEvent('gridsystem:registerMarker', {
                name = 'dorgheRaccogli_'..v.Raccolta.pos.x,
                pos = vector3(v.Raccolta.pos.x, v.Raccolta.pos.y, v.Raccolta.pos.z+0.1),
                scale = vector3(0.7, 0.7, 0.7),
                msg = 'Premi ~b~[E]~w~ per raccogliere ~b~'..k..'~2~',
                control = 'E',
                type = 31,
                color = {r = 255, g = 255, b = 255},
                --rotazione = true,
                show3D = true,
                --float3d = true,
                --float4d = true,
                action = function()
                    if not raccogliendo then
                        raccogliendo = true
                        ExecuteCommand('e mechanic3')
                        ESX.Barra(4000, 'Raccogliendo ' ..k)
                        FreezeEntityPosition(PlayerPedId(), true)
                        Citizen.Wait(4000)
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), false)
                        --TriggerServerEvent('raccoltadroga', v.itemRaccolta, v.polizia)
                        TriggerServerEvent('falkon_droghe:raccolta', v.Raccolta)
                        raccogliendo = false
                    end
                end,
            })
            TriggerEvent('gridsystem:registerMarker', {
                name = 'dorgheRaccogli_'..v.Processo.pos.x,
                pos = vector3(v.Processo.pos.x, v.Processo.pos.y, v.Processo.pos.z+0.1),
                scale = vector3(0.7, 0.7, 0.7),
                msg = 'Premi ~b~[E]~w~ per processare ~b~'..k..'~2~',
                control = 'E',
                type = 31,
                color = {r = 255, g = 255, b = 255},
                --rotazione = true,
                --show3D = true,
                --float3d = true,
                show3D = true,
                --float4d = true,
                action = function()
                    if not raccogliendo then
                        raccogliendo = true
                        ExecuteCommand('e mechanic3')
                        ESX.Barra(4000, 'Processando ' ..k)
                        FreezeEntityPosition(PlayerPedId(), true)
                        Citizen.Wait(4000)
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('falkon_droghe:processo', v.Processo)
                        raccogliendo = false
                    end
                end,
            })
            TriggerEvent('gridsystem:registerMarker', {
                name = 'dorgheRaccogli_'..v.Vendita.pos.x,
                pos = vector3(v.Vendita.pos.x, v.Vendita.pos.y, v.Vendita.pos.z+0.1),
                scale = vector3(0.7, 0.7, 0.7),
                msg = 'Premi ~b~[E]~w~ per vendere ~b~'..k..'~2~',
                control = 'E',
                type = 31,
                color = {r = 255, g = 255, b = 255},
                --rotazione = true,
                --show3D = true,
                --float3d = true,
                show3D = true,
                --float4d = true,
                action = function()
                    if not raccogliendo then
                        raccogliendo = true
                        ExecuteCommand('e leanbar2')
                        ESX.Barra(4000, 'Vendendo ' ..k)
                        FreezeEntityPosition(PlayerPedId(), true)
                        Citizen.Wait(4000)
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('falkon_droghe:vendita', v.Vendita)
                        raccogliendo = false
                    end
                end,
            })
        end
    end)
end