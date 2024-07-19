local inventory = exports['ox_inventory']

lib.callback.register('sharky_saferobbery:server:robberySuccess', function(source, reward)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    xPlayer.addMoney(reward)

    --logToDiscord(xPlayer.name .. ' has cracked a safe and earned $' .. reward)
end)
