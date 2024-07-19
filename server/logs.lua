local ROBBERY_WEBHOOK = "https://discord.com/api/webhooks/890000000000000000/"

function logToDiscord(message)
    local connect = {
        {
            ["color"] = 16711680,
            ["title"] = "SafeRobbery", -- Ne változtasd meg!
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %X"),
            },
        }
    }
    PerformHttpRequest(ROBBERY_WEBHOOK, function(err, text, headers) end, 'POST',
        json.encode({ username = "Sharky SafeRobbery - LOG", embeds = connect, avatar_url = "" }),
        { ['Content-Type'] = 'application/json' })
end
