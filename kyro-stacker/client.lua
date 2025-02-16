local isGameOpen = false

RegisterNetEvent('kyro:stacker:toggleGame')
AddEventHandler('kyro:stacker:toggleGame', function()

    
    
    local result = lib.alertDialog({
        header = 'Stacker?',
        content =  ' Stacker uses **1k VIP credits**. \n\n   Each level you stack gives you a cash bonus! \n\n  • **Minor prize**: Pistol crate \n\n • **Major prize**: AR crate \n\n • **Use SPACEBAR to level up** \n\n  •     • **Press Confirm To Play**  •     ',
        cancel = true,  -- Allows the cancel button to appear

    })

    if result == 'confirm' then
        -- User clicked 'Start' (confirm button)
        isGameOpen = not isGameOpen
        SetNuiFocus(isGameOpen, isGameOpen)
        
        if isGameOpen then
            TriggerServerEvent('stacker:start')
            SendNUIMessage({ action = "openStackerGame" })
        else
            SendNUIMessage({ action = "closeStackerGame" })
        end
    else
        -- User clicked 'Cancel' or closed the dialog
        print('User canceled the action.')
    end
end)


-- Example of how to trigger the event (you can trigger this from anywhere on the client side)
-- TriggerEvent('stacker:toggleGame')


-- NUI callback to close the game
RegisterNUICallback('kyro:stacker:Close', function(data)
  isGameOpen = false
    SetNuiFocus(false, false)
    

end)


RegisterNUICallback('kyro:stacker:CurrentLevel', function(data, cb)
    if data and data.level then
        TriggerServerEvent('kyro-stacker:count', data.level)

        -- Check level and print appropriate message
        if data.level == 11 then
            TriggerServerEvent('kyro-stacker:count1')
        elseif data.level == 16 then
            TriggerServerEvent('kyro-stacker:count2')
        else
      
        end
    else

    end
    cb('ok')
end)
