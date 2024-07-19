--[[ Prop Spawnolása ]]
lib.locale()

local inventory = exports['ox_inventory']
local safesCooldown = {} -- Széfek cooldown állapotának tárolása

Citizen.CreateThread(function()
    for k, v in pairs(Config['Safes']) do
        local prop = v.Prop
        lib.requestModel(prop)
        local propEntity = CreateObject(GetHashKey(prop), v.Coords, true, false, false)
        SetEntityAsMissionEntity(propEntity, true, true)
        FreezeEntityPosition(propEntity, true)

        DevPrint("Prop spawned: " .. prop)

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
                            if inventory:GetItemCount(v.RequiredItem) > 0 then
                                lib.requestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", 100)

                                TaskPlayAnim(cache.ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                    "machinic_loop_mechandplayer", 8.0, 8.0, -1, 1, 0, 0, 0, 0)

                                FreezeEntityPosition(cache.ped, true)
                                local success = lib.skillCheck(v.Difficulty)

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
                                        local reward = math.random(v.Reward.min, v.Reward.max)
                                        lib.callback('sharky_saferobbery:server:robberySuccess', false, function()
                                            Notify(locale('crack_success', reward))
                                            safesCooldown[k] = currentTime + v.Cooldown * 1000 -- Cooldown beállítása
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
                            lib.requestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", 100)
                            SetEntityCoords(cache.ped, v.Coords.x, v.Coords.y - 1.0, v.Coords.z, 1, 0, 0, 1)
                            TaskPlayAnim(cache.ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                "machinic_loop_mechandplayer", 8.0, 8.0, -1, 1, 0, 0, 0, 0)

                            FreezeEntityPosition(cache.ped, true)

                            local success = lib.skillCheck(v.Difficulty)

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
                                    local reward = math.random(v.Reward.min, v.Reward.max)
                                    lib.callback('sharky_saferobbery:server:robberySuccess', false, function()
                                        Notify(locale('crack_success', reward))
                                        safesCooldown[k] = currentTime + v.Cooldown * 1000 -- Cooldown beállítása
                                    end, reward)
                                    ClearPedTasks(cache.ped)
                                    FreezeEntityPosition(cache.ped, false)
                                end
                            else
                                Notify(locale('crack_failed'))
                                ClearPedTasks(cache.ped)
                                FreezeEntityPosition(cache.ped, false)
                            end
                        end
                    end
                end
            end
        })

        if v.Blip.enable then
            CreateBlip(v.Coords, v.Blip.name, v.Blip.color, v.Blip.sprite)
        end
    end
end)

AddEventHandler('onResourceStop', function()
    DeleteObject(propEntity)
end)
