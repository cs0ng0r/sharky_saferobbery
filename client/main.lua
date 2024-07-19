lib.locale()

local inventory = exports['ox_inventory']
local safesCooldown = {}
local reward = 0

Citizen.CreateThread(function()
    for k, v in pairs(Config['Safes']) do
        local prop = v.Prop
        lib.requestModel(prop)
        local propEntity = CreateObject(GetHashKey(prop), v.Coords, true, false, false)
        SetEntityAsMissionEntity(propEntity, true, true)
        FreezeEntityPosition(propEntity, true)

        DevPrint("Prop Spawn: " .. prop)

        local zone = lib.zones.sphere({
            coords = v.Coords,
            radius = 1.5,
            debug = false,
            inside = function()
                if not Config['target'] then
                    TextUI(locale('crack_safe'))

                    if IsControlJustReleased(0, 38) then
                        local currentTime = GetGameTimer()
                        if safesCooldown[k] and currentTime < safesCooldown[k] then
                            Notify(locale('safe_on_cooldown', math.ceil((safesCooldown[k] - currentTime) / 1000)))
                            return
                        end

                        if v.RequiredItem then
                            ESX.TriggerServerCallback('sharky_saferobbery:server:canRobSafe', function(canRob)
                                if canRob then
                                    if inventory:GetItemCount(v.RequiredItem) > 0 then
                                        lib.requestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", 100)

                                        TaskPlayAnim(cache.ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                            "machinic_loop_mechandplayer", 8.0, 8.0, -1, 1, 0, 0, 0, 0)

                                        FreezeEntityPosition(cache.ped, true)
                                        local success = lib.skillCheck(v.Difficulty)
                                        canRob = false

                                        if success then
                                            if lib.progressBar({
                                                    duration = v.LootTime * 1000,
                                                    label = locale('looting_safe'),
                                                    useWhileDead = false,
                                                    canCancel = false,
                                                    disable = {
                                                        move = true,
                                                    },
                                                }) then
                                                reward = math.random(v.Reward.min, v.Reward.max)
                                                lib.callback('sharky_saferobbery:server:robberySuccess', false,
                                                    function()
                                                        Notify(locale('crack_success', reward))
                                                        safesCooldown[k] = GetGameTimer() +
                                                            v.Cooldown *
                                                            1000          -- Update cooldown
                                                    end, reward)
                                                ClearPedTasks(cache.ped)
                                                FreezeEntityPosition(cache.ped, false)
                                            else
                                                Notify(locale('crack_failed'))
                                                ClearPedTasks(cache.ped)
                                                FreezeEntityPosition(cache.ped, false)
                                            end
                                        end
                                    else
                                        Notify(locale('item_needed', v.RequiredItem))
                                    end
                                else
                                    Notify(locale('safe_on_cooldown', 60))
                                end
                            end, k)
                        else
                            ESX.TriggerServerCallback('sharky_saferobbery:server:canRobSafe', function(canRob)
                                if canRob then
                                    TriggerServerEvent('sharky_saferobbery:server:policeNotify', v.Coords.x, v.Coords.y, v.Coords.z)
                                    lib.requestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", 100)
                                    SetEntityCoords(cache.ped, v.Coords.x, v.Coords.y - 1.0, v.Coords.z, 1, 0, 0, 1)
                                    TaskPlayAnim(cache.ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                        "machinic_loop_mechandplayer", 8.0, 8.0, -1, 1, 0, 0, 0, 0)

                                    FreezeEntityPosition(cache.ped, true)
                                    local success = lib.skillCheck(v.Difficulty)
                                    canRob = false

                                    if success then
                                        if lib.progressBar({
                                                duration = v.LootTime * 1000,
                                                label = locale('looting_safe'),
                                                useWhileDead = false,
                                                canCancel = false,
                                                disable = {
                                                    move = true,
                                                },
                                            }) then
                                            reward = math.random(v.Reward.min, v.Reward.max)
                                            lib.callback('sharky_saferobbery:server:robberySuccess', false, function()
                                                Notify(locale('crack_success', reward))
                                                safesCooldown[k] = GetGameTimer() + v.Cooldown * 1000 -- Update cooldown
                                            end, reward)
                                            ClearPedTasks(cache.ped)
                                            FreezeEntityPosition(cache.ped, false)
                                        else
                                            Notify(locale('crack_failed'))
                                            ClearPedTasks(cache.ped)
                                            FreezeEntityPosition(cache.ped, false)
                                        end
                                    end
                                else
                                    Notify(locale('safe_on_cooldown', 60))
                                end
                            end, k)
                        end
                    end
                end
            end
        })

        if Config['target'] then
            exports.ox_target:addSphereZone({
                coords = v.Coords,
                radius = 1.5,
                debug = Config['debug'],
                options = {
                    {
                        icon = "fas fa-lock",
                        label = locale('crack_safe_target'),
                        onSelect = function()
                            local currentTime = GetGameTimer()
                            local currentTime = GetGameTimer()
                            if safesCooldown[k] and currentTime < safesCooldown[k] then
                                Notify(locale('safe_on_cooldown', math.ceil((safesCooldown[k] - currentTime) / 1000)))
                                return
                            end

                            if v.RequiredItem then
                                ESX.TriggerServerCallback('sharky_saferobbery:server:canRobSafe', function(canRob)
                                    if canRob then
                                        if inventory:GetItemCount(v.RequiredItem) > 0 then
                                            lib.requestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", 100)

                                            TaskPlayAnim(cache.ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                                "machinic_loop_mechandplayer", 8.0, 8.0, -1, 1, 0, 0, 0, 0)

                                            FreezeEntityPosition(cache.ped, true)
                                            local success = lib.skillCheck(v.Difficulty)
                                            canRob = false

                                            if success then
                                                if lib.progressBar({
                                                        duration = v.LootTime * 1000,
                                                        label = locale('looting_safe'),
                                                        useWhileDead = false,
                                                        canCancel = false,
                                                        disable = {
                                                            move = true,
                                                        },
                                                    }) then
                                                    reward = math.random(v.Reward.min, v.Reward.max)
                                                    lib.callback('sharky_saferobbery:server:robberySuccess', false,
                                                        function()
                                                            Notify(locale('crack_success', reward))
                                                            safesCooldown[k] = GetGameTimer() +
                                                                v.Cooldown *
                                                                1000      -- Update cooldown
                                                        end, reward)
                                                    ClearPedTasks(cache.ped)
                                                    FreezeEntityPosition(cache.ped, false)
                                                else
                                                    Notify(locale('crack_failed'))
                                                    ClearPedTasks(cache.ped)
                                                    FreezeEntityPosition(cache.ped, false)
                                                end
                                            end
                                        else
                                            Notify(locale('item_needed', v.RequiredItem))
                                        end
                                    else
                                        Notify(locale('safe_on_cooldown', 60))
                                    end
                                end, k)
                            else
                                ESX.TriggerServerCallback('sharky_saferobbery:server:canRobSafe', function(canRob)
                                    if canRob then
                                        TriggerServerEvent('sharky_saferobbery:server:policeNotify', v.Coords)
                                        lib.requestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", 100)
                                        SetEntityCoords(cache.ped, v.Coords.x, v.Coords.y - 1.0, v.Coords.z, 1, 0, 0, 1)
                                        TaskPlayAnim(cache.ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                            "machinic_loop_mechandplayer", 8.0, 8.0, -1, 1, 0, 0, 0, 0)

                                        FreezeEntityPosition(cache.ped, true)
                                        local success = lib.skillCheck(v.Difficulty)
                                        canRob = false

                                        if success then
                                            if lib.progressBar({
                                                    duration = v.LootTime * 1000,
                                                    label = locale('looting_safe'),
                                                    useWhileDead = false,
                                                    canCancel = false,
                                                    disable = {
                                                        move = true,
                                                    },
                                                }) then
                                                reward = math.random(v.Reward.min, v.Reward.max)
                                                lib.callback('sharky_saferobbery:server:robberySuccess', false,
                                                    function()
                                                        Notify(locale('crack_success', reward))
                                                        safesCooldown[k] = GetGameTimer() +
                                                        v.Cooldown * 1000                             -- Update cooldown
                                                    end, reward)
                                                ClearPedTasks(cache.ped)
                                                FreezeEntityPosition(cache.ped, false)
                                            else
                                                Notify(locale('crack_failed'))
                                                ClearPedTasks(cache.ped)
                                                FreezeEntityPosition(cache.ped, false)
                                            end
                                        end
                                    else
                                        Notify(locale('safe_on_cooldown', 60))
                                    end
                                end, k)
                            end
                        end
                    },
                },
            })
        end

        if v.Blip.enable then
            CreateBlip(v.Coords, v.Blip.name, v.Blip.color, v.Blip.sprite)
        end
    end
end)

AddEventHandler('onResourceStop', function()
    DeleteObject(propEntity)
    DeleteEntity(propEntity)
end)

RegisterNetEvent('sharky_saferobbery:client:notifyPolice') 
AddEventHandler('sharky_saferobbery:client:notifyPolice', function(coords)
    CreateThread(function ()
        print(coords)
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, 161)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Safe Robbery")
        EndTextCommandSetBlipName(blip)
        Config['PoliceNotify'](locale('robbery_started'))
        Wait(60000)
        RemoveBlip(blip)

    end)
end)