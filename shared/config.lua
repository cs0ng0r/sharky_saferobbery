Config = {}

Config['locale'] = 'en'       -- language for the script
Config['debug'] = false       -- enable debugging prints
Config['target'] = false      -- enable target | or false to disable (ox_target)
Config['textui'] =
"esx"                         -- ESX.ShowHelpNotification | Use "custom" and write your own logic in Config['CustomTextUI']
Config['minigame'] = "ox_lib" -- safelock or ox_lib for minigame
Config['blackmoney'] = true   -- enable black money reward

Config['jobs'] = {
    'police',
    'sheriff',
}

Config['Safes'] = {
    {
        Coords = vector4(236.4954, -879.6640, 29.4921, 153.0743), -- coords for the prop
        Prop = 'prop_ld_int_safe_01',                             -- prop you want to spawn
        RequiredItem = false,                                     -- item name or false
        GiveBlackMoney = true,                                    -- give black money
        Reward = {
            min = 1000,                                           -- min reward
            max = 2000,                                           -- max reward
        },
        Difficulty = { "easy", "easy", "medium" },                -- easy, medium, hard
        LootTime = 10,                                            -- time to loot the safe
        Cooldown = 60,                                            -- cooldown in seconds
        Blip = {
            enable = true,
            sprite = 303,
            color = 1,
            name = 'Safe',
        }
    },
}


Config['Notify'] = "esx" -- ESX or OX_LIB notify | Use "custom" and write your own logic in Config['CustomNotify']

Config['CustomNotify'] = function(message)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0 },
        multiline = true,
        args = { "[Safe]", message }
    })
end

Config['PoliceNotify'] = function(message)
    TriggerEvent('chat:addMessage', {
        color = { 0, 0, 255 },
        multiline = true,
        args = { "[Safe]", message }
    })
end

Config['CustomTextUI'] = function(msg)
end
