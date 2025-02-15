Config = {}

--webhooks place your webhook url between the two '
ChestWebhook = '' --will display when someone opens a chest who did it what items they got what chest etc
ShopWebhook = '' --this is what will display when someone sells or buys from nazar


--This is the nazar configuration
Config.NazarSetup = {
    blip = true, --if true this will place a blip on nazar if not no blip will be there
    nazarspawn = { --it will pick one of these 4 coordinates upon start. You can not have more or less than 4 without editing the code
        {x = -1047.19, y = 450.55, z = 56.81, h = 178.68}, --to get coords use xyz paste then manually add the heading to the table
        {x = -1308.82, y = 395.05, z = 95.38, h = 95.98},
        {x = -2698.67, y = -1500.59, z = 152.03, h = 294.63},
        {x = -1447.93, y = -2297.07, z = 43.37, h = 229.05},
        {x = 2451.7, y = 2097.02, z = 173.33, h = 229.05},
        {x = -943.65, y = 2181.4, z = 342.34, h = 229.05},
    }, --where she will be
    hintcooldown = 300000, --this is the cooldown between hints
}

--This is the treasure chest setup you can not add anymore sadly only configure the existing ones there are 20 in total and i can add more if enough people want more
Config.TreasureLocations = {
    {
        huntname = 'Grizzlies West', --the name that will show when buying a hint from nazar
        location = {x = -960.33, y = 1630.17, z = 246.58}, --the location of the chest
        Reward = { --this is the rewards -- you can add as many rewards per chest as you want use the existing rewards as a guide to add more
            {
                name = 'wheat', --this has to be the database name of the item
                count = 1, --the amount of the item you want it to give
            },
            {
                name = 'water',
                count = 7,
            },
        },
    },
    {
        huntname = 'Girzzlies east',
        location = {x = -2728.65, y = -1464.78, z = 153.06},
        Reward = {
            {
                name = 'shovel',
                count = 1,
            },
        },
    },
}


--This is the shop configuration
--You can add as many items to sale as you want just copy the line paste it and change it to your new item
--itemdbname is the database name of the item and displayname is what will show in the menu with nazar

--This is what she will purchase from the player
Config.Shop = {
    { itemdbname = 'wheat', displayname = 'wheat', price = '5'},
    { itemdbname = 'water', displayname = 'water', price = '2'},
}

-- This is what she will sell to the player
Config.Nazarssellableitems = {
    { itemdbname = 'water', displayname = 'water', price = 3},
    { itemdbname = 'wheat', displayname = 'Wheat', price = 7},
}
