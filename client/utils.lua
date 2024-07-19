function DevPrint(msg)
    if Config['debug'] then
        print(msg)
    end
end

function CreateBlip(coords, name, color, sprite)
    Citizen.CreateThread(function()
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(name)
        EndTextCommandSetBlipName(blip)
        return blip
    end)
end

function Notify(msg)
    if Config['Notify'] == "esx" then
        ESX.ShowNotification(msg)
    elseif Config['Notify'] == "ox" then
        lib.notify({
            description = msg,
        })
    elseif Config['Notify'] == "custom" then
        Config['CustomNotify'](msg)
    else
        lib.print.error("Invalid notify")
    end
end

function TextUI(text)
    if Config['textui'] == "esx" then
        ESX.ShowHelpNotification(text)
    elseif Config['textui'] == "custom" then
        Config['CustomTextUI'](text)
    else
        lib.print.error("Invalid textui")
    end
end

