local inventory = exports['ox_inventory']
local canRob = {}

lib.callback.register('sharky_saferobbery:server:robberySuccess', function(source, reward)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if not xPlayer then return end
    if Config['blackmoney'] then
        xPlayer.addInventoryItem('black_money', reward)
    else
        xPlayer.addMoney(reward)
    end

    --logToDiscord(xPlayer.name .. ' has cracked a safe and earned $' .. reward)
end)



RegisterServerEvent('sharky_saferobbery:server:policeNotify', function(coordsx, coordsy, coordsz)
    local xPlayers = ESX.GetPlayers()

    for _, v in pairs(Config['jobs']) do
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(tonumber(xPlayers[i]))
            if xPlayer.job.name == v then
                TriggerClientEvent('sharky_saferobbery:client:notifyPolice', tonumber(xPlayers[i]), vec3(coordsx, coordsy, coordsz))
            end
        end
    end
end)


ESX.RegisterServerCallback('sharky_saferobbery:server:canRobSafe', function(source, cb, safeId)
    local _source = source
    if Config['Safes'][safeId] == nil then
        cb(false)
        return
    end

    if canRob[safeId] then
        cb(false)
        return
    end

    canRob[safeId] = _source
    cb(true)
end)
