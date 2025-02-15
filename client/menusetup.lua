--Pulls vorp core

local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)
--end pulling it
Cooldown = false
StopAll = false

--Main Menu
Citizen.CreateThread(function()
    WarMenu.CreateMenu('hd_nazar:menu', 'Madam Nazar') --creates the main menu
    WarMenu.CreateSubMenu('hd_nazar:shop', 'hd_nazar:menu', 'Sell Items')
    WarMenu.CreateSubMenu('hd_nazar:sell', 'hd_nazar:menu', 'Buy Hints')
    WarMenu.CreateSubMenu('hd_nazar:nazarsshop', 'hd_nazar:menu', 'Buy Items')
    while true do
        if WarMenu.IsMenuOpened('hd_nazar:menu') then --if menu is opened then
            if WarMenu.Button('Hint Shop', '', 'Purchase Hints') then --creates the hint shop option
                WarMenu.OpenMenu('hd_nazar:sell') --opens the sell menu
            end
            if WarMenu.Button('Sell', '', 'Sell Items') then --creates the shop option
                WarMenu.OpenMenu('hd_nazar:shop') --opens the menu
            end
            if WarMenu.Button('Buy', '', 'Buy Items') then
                WarMenu.OpenMenu('hd_nazar:nazarsshop')
            end
        end
        if WarMenu.IsMenuOpened('hd_nazar:sell') then
            for k, v in pairs(Config.TreasureLocations) do --starts a for loop which creates multiple menus depending on the config
                if WarMenu.Button(v.huntname, '', 'Purchase a Hint ') then --creates a option for each thing in config lua
                    local cost = v.hintcost
                    C = v.location
                    V = v
                    TriggerServerEvent('hd_nazar:menuopen6', cost) --triggers server event which is the cooldown event 
                    RegisterNetEvent('hd_nazar:menuopen4') --creates a net event for the serever to call
                    AddEventHandler('hd_nazar:menuopen4', function() --makes the net event have something to run
                        VORPcore.NotifyBottomRight("A clue to some treasure has been marked",6000) --text in bottom right
                        WarMenu.CloseMenu() --closes the menu
                        searchforchest()
                    end)
                end
            end
        end
        if WarMenu.IsMenuOpened('hd_nazar:shop') then
            for p, u in pairs(Config.Shop) do --opens the shop table
                if WarMenu.Button('Sell ' .. u.displayname .. ' For ' .. u.price, '', '') then --creates a menu per thing in the shop
                    Iitemname = u.itemdbname --sets the varible to whatever option is clicked
                    Pprice = u.price --sets the price variable to the config lua
                    --This is from vorpinputs to get the amount they want to sell
                    local myInput = {
                        type = "enableinput", -- dont touch
                        inputType = "input", -- or text area for sending messages
                        button = "confirm", -- button name
                        placeholder = "insertamount", --placeholdername
                        style = "block", --- dont touch
                        attributes = {
                            inputHeader = "amount", -- header
                            type = "number", -- inputype text, number,date.etc if number comment out the pattern
                            pattern = "[0-9]{1,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                            title = "must be only numbers min 1 max 20", -- if input doesnt match show this message
                            style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                        }
                    }
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput),function(result)
                        local qty = tonumber(result)
                        if qty > 0 then
                            TriggerServerEvent("hd_nazar:catchinputforsell",  qty) --result
                        else
                            TriggerEvent("vorp:TipRight", "insertamount", 3000)
                        end
                    end)
                    WarMenu.CloseMenu() -- closes the menu to stop the loop
                    --TriggerServerEvent('getplayerdataforsell', itemname, price) --triggers a server event and passes the variable
                end
            end
        end
        if WarMenu.IsMenuOpened('hd_nazar:nazarsshop') then
            for k, e in pairs(Config.Nazarssellableitems) do
                if WarMenu.Button('Buy ' .. e.displayname .. ' for ' .. e.price .. '?') then
                    Itemnamee = e.itemdbname
                    Priceee = e.price
                    local myInput = {
                        type = "enableinput", -- dont touch
                        inputType = "input", -- or text area for sending messages
                        button = "confirm", -- button name
                        placeholder = "insertamount", --placeholdername
                        style = "block", --- dont touch
                        attributes = {
                            inputHeader = "amount", -- header
                            type = "number", -- inputype text, number,date.etc if number comment out the pattern
                            pattern = "[0-9]{1,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                            title = "must be only numbers min 1 max 20", -- if input doesnt match show this message
                            style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                        }
                    }
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput),function(result)
                        local qty = tonumber(result)
                        if qty > 0 then
                            TriggerServerEvent("hd_nazar:nazarsellinfopass",  qty) --result
                        else
                            TriggerEvent("vorp:TipRight", "insertamount", 3000)
                        end
                    end)
                    WarMenu.CloseMenu() -- closes the menu to stop the loop
                end
            end
        end
        WarMenu.Display() --makes the menu show
        Citizen.Wait(0) --prevents crashing
    end
end)

--This recieves the qty when buying from nazar and then passes the qty along with the item name and price to the server to handle giving the items
RegisterNetEvent('hd_nazar:nazarsellableitemscatch')
AddEventHandler('hd_nazar:nazarsellableitemscatch', function(qty) --is catching the qty from the server
    TriggerServerEvent('hd_nazar:buyfromnazar', qty, Itemnamee, Priceee) --is passing the 3 variables to the server
end)


--this recieves the qty when selling items to nazar from the server and then passes the itemname and price to the server along with the qty
RegisterNetEvent('hd_nazar:infosenderforsell')
AddEventHandler('hd_nazar:infosenderforsell', function(qty)
    TriggerServerEvent('hd_nazar:getplayerdataforsell', Iitemname, Pprice, qty)
end)

function openlegmenu() --creates a function named openlegmenu
    WarMenu.OpenMenu('hd_nazar:menu') --opens the main menu
end

RegisterNetEvent('hd_nazar:failmenuopen') --this is the event that will trigger if cooldown is true
AddEventHandler('hd_nazar:failmenuopen', function() --makes the event do something
    VORPcore.NotifyBottomRight('I have nothing to offer currently come back later', 4000) --prints this in players screen
end)

Citizen.CreateThread(function() --runs on start
    if Cooldown == false then --if cooldown is false then
        while true do --creates loop
            Citizen.Wait(0) --prevents crashing
            local player = GetEntityCoords(PlayerPedId()) --gets players coords
            if GetDistanceBetweenCoords(Nspawn.x, Nspawn.y, Nspawn.z, player.x, player.y, player.z, false) < 2 then
                if IsControlJustReleased(0, 0x760A9C6F) then
                    openlegmenu()
                end
            end
        end
    end
end)
--End menu setup

RegisterNetEvent('hd_nazar:noitem') --creates a client event that prints no item
AddEventHandler('hd_nazar:noitem', function()
    VORPcore.NotifyBottomRight('you do not have this item', 4000) --prints this in players screen
end)

RegisterNetEvent('hd_nazar:nomon') --creates a client event that prints no item
AddEventHandler('hd_nazar:nomon', function()
    VORPcore.NotifyBottomRight('You do not have enough cash', 4000) --prints this in players screen
end)

RegisterNetEvent('hd_nazar:ccdown2') --creates a client event that prints no item
AddEventHandler('hd_nazar:ccdown2', function()
    VORPcore.NotifyBottomRight('You looted the chest!', 4000) --prints this in players screen
end)