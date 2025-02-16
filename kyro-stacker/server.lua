local QBCore = exports['qb-core']:GetCoreObject()

webhook = "discord webhook"
playcost = 10000   -- cost to play


RegisterCommand("stacker", function(source, args, rawCommand)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local cost = playcost

    -- Check if the player has enough bank money
    if Player.Functions.GetMoney('bank') >= cost then
        Player.Functions.RemoveMoney('bank', cost, "Stacker Game Entry")
        TriggerClientEvent('kyro:stacker:toggleGame', source)
    else
        -- Not enough money, send a message
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^1ERROR", "You don't have enough money in your bank to play the Stacker game."}
        })
    end
end, false)

RegisterServerEvent('kyro:stacker:start')
AddEventHandler('kyro:stacker:start', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local cost = 1000

    -- Check if the player has enough bank money
    if Player.Functions.GetMoney('bank') >= cost then
        Player.Functions.RemoveMoney('bank', cost, "Stacker Game Entry")

        -- Discord log variables
        local owner = Player.PlayerData.citizenid
        local firstname = Player.PlayerData.charinfo.firstname
        local lastname = Player.PlayerData.charinfo.lastname

        -- Successful deduction, send Discord log
        local dat = {
            {
                ["name"] = "**"..owner..":**",
                ["value"] = firstname .. " " .. lastname .. " started stacker",
                ["inline"] = false
            },
            {
                ["name"] = "**Bank Info**",
                ["value"] = "Deducted: $" .. cost,
                ["inline"] = false
            }
        }

        sendToDiscord(dat, 32768, "Started Stacker", webhook)    

        -- Trigger the game start event
        TriggerClientEvent('kyro:stacker:toggleGame', source)
    else
        -- Not enough money, send a message
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^1ERROR", "You don't have enough money in your bank to play the Stacker game."}
        })
    end
end)



RegisterServerEvent('kyro-stacker:count', function(level)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local money = 0

    if level == 1 then
        money = 5000
    elseif level == 2 then
        money = 5000
    elseif level == 3 then
        money =  5000
    elseif level == 4 then
        money = 5000
    elseif level == 5 then
        money =  5000
    elseif level == 6 then
        money =  5000
    elseif level == 7 then
        money =  5000
    elseif level == 8 then
        money =  5000
    elseif level == 9 then
        money = 100000
    elseif level == 10 then
        money = 10000
    elseif level == 11 then
        money = 10000
    elseif level == 12 then
        money = 10000
    elseif level == 13 then
        money = 10000
    elseif level == 14 then
        money = 10000
    elseif level == 15 then
        money = 10000
    end

    -- Add the money to the player's account
    if money > 0 then
        Player.Functions.AddMoney('cash', money, "Stacker")
    end
end)




function sendToDiscord(field, colour, titles, webhook)
    local embed = {
          {
              ["fields"] = field,
              ["color"] = colour,
              ["title"] = titles,
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "Server Timestamp: "..os.date("%x %X %p"),
              },
              ["thumbnail"] = {
                  ["url"] = "https://cdn.discordapp.com/attachments/1235149859070279683/1269337139079024660/Black_Grey_Aqua_Grunge_Gaming_YouTube_Banner.png?ex=6759c355&is=675871d5&hm=236c9d2988dd715f6a244b35e6b050e9641d72ed46a5c7d4316187c73fa0f96c&",
              },
          }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Kyro Stacker", embeds = embed, avatar_url = "https://cdn.discordapp.com/attachments/1235149859070279683/1269337139079024660/Black_Grey_Aqua_Grunge_Gaming_YouTube_Banner.png?ex=6759c355&is=675871d5&hm=236c9d2988dd715f6a244b35e6b050e9641d72ed46a5c7d4316187c73fa0f96c&"}), { ['Content-Type'] = 'application/json' })
end