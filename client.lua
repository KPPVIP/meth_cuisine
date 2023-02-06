

ESX = nil

local isProcessing = false
local distressBottle = false
local mixfosfor = false
local inGas = false
local sayac = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)



-- StageOne //
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 
        local sleep = 1000
        local playerPed = GetEntityCoords(PlayerPedId())
        local player = PlayerPedId()
        local dst = GetDistanceBetweenCoords(playerPed, Config.kordinatlar.aseton.x, Config.kordinatlar.aseton.y, Config.kordinatlar.aseton.z, true)
        if dst <= 1 then
            sleep = 1
            if not isProcessing then
                DrawText3D( Config.kordinatlar.aseton.x, Config.kordinatlar.aseton.y, Config.kordinatlar.aseton.z+0.40, "~g~[E]~w~ Acétones en bouteille ~w~", 0.45)
                if IsControlJustPressed(0, 38) and not isProcessing then
                    ESX.TriggerServerCallback("eff_meth:checkItem", function(output)
                        if output then
                            TriggerServerEvent("eff_meth:removeItem", "acetone", 1)
                            SetEntityHeading(player, Config.kordinatlar.aseton.h)
                            StageOne()
                        elseif not output then
                            exports['mythic_notify']:SendAlert("error", "Pas d'acétone")
                        end
                    end, "acetone", 1)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- StageTwo //
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 
        local sleep = 1000
        local playerPed = GetEntityCoords(PlayerPedId())
        local player = PlayerPedId()
        local dst = GetDistanceBetweenCoords(playerPed, Config.kordinatlar.damitma.x, Config.kordinatlar.damitma.y, Config.kordinatlar.damitma.z, true)
        if dst <= 1 then
            sleep = 1
            if not isProcessing then
                DrawText3D( Config.kordinatlar.damitma.x, Config.kordinatlar.damitma.y, Config.kordinatlar.damitma.z+0.40, "~g~[E]~w~ Distiller l'acétone en bouteille ~w~", 0.45)
                if IsControlJustPressed(0, 38) and not isProcessing then
                    ESX.TriggerServerCallback("eff_meth:checkItem", function(output)
                        if output then
                            TriggerServerEvent("eff_meth:removeItem", "acetonebottle", 2)
                            SetEntityHeading(player, Config.kordinatlar.damitma.h)
                            StageTwo()
                        elseif not output then
                            exports['mythic_notify']:SendAlert("error", "Pas d'acétone en bouteille")
                        end
                    end, "acetonebottle", 2)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)


-- StageThree //
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1) 
        local sleep = 1000
        local playerPed = GetEntityCoords(PlayerPedId())
        local player = PlayerPedId()
        local dst = GetDistanceBetweenCoords(playerPed, Config.kordinatlar.fosfor.x, Config.kordinatlar.fosfor.y, Config.kordinatlar.fosfor.z, true)
        if dst <= 1 then
            sleep = 1
            if not isProcessing then
                DrawText3D( Config.kordinatlar.fosfor.x, Config.kordinatlar.fosfor.y, Config.kordinatlar.fosfor.z+0.40, "~g~[E]~w~ Mélanger l'acétone et le phosphore ~w~", 0.45)
                if IsControlJustPressed(0, 38) and not isProcessing then
                    ESX.TriggerServerCallback("eff_meth:checkItem", function(output)
                        if output then
                            SetEntityHeading(player, Config.kordinatlar.fosfor.h)
                            TriggerEvent("eff_meth:questback")
                        elseif not output then
                            exports['mythic_notify']:SendAlert("error", "Pas d'acétone distillée")
                        end
                    end, "distilledbottle", 2)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent("eff_meth:questback")
AddEventHandler("eff_meth:questback", function()
ESX.TriggerServerCallback("eff_meth:checkItem", function(output)
    if output then
        TriggerEvent("eff_meth:questions")
    elseif not output then
        exports['mythic_notify']:SendAlert("error", "Pas de phosphore rouge")
    end
    end, "phosphorus", 2)
end)

-- stageFour //
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 
        local sleep = 1000
        local playerPed = GetEntityCoords(PlayerPedId())
        local player = PlayerPedId()
        local dst = GetDistanceBetweenCoords(playerPed, Config.kordinatlar.aluminyum.x, Config.kordinatlar.aluminyum.y, Config.kordinatlar.aluminyum.z, true)
        if dst <= 1 then
            sleep = 1
            if not isProcessing then
                DrawText3D( Config.kordinatlar.aluminyum.x, Config.kordinatlar.aluminyum.y, Config.kordinatlar.aluminyum.z+0.40, "~g~[E]~w~ Mettez le mélange au four ~w~", 0.45)
                if IsControlJustPressed(0, 38) and not isProcessing then
                    ESX.TriggerServerCallback("eff_meth:checkItem", function(output)
                        if output then
                            SetEntityHeading(player, Config.kordinatlar.aluminyum.h)
                            StageFour()
                           -- TriggerEvent("eff_meth:questionstwo")
                        elseif not output then
                            exports['mythic_notify']:SendAlert("error", "Pas de mélange méth")
                        end
                    end, "mixedmeth", 1)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- StageOne //
function StageOne()
    isProcessing = true
        TriggerEvent("mythic_progbar:client:progress", {
                name = "acetone",
                duration = 10000,
                label = "Les acétones sont en bouteille...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end)  
  Citizen.Wait(10000)
  TriggerServerEvent("eff_meth:giveItem", "acetonebottle", 2)
  isProcessing = false
end

-- StageTwo //
function StageTwo()
    isProcessing = true
    distressBottle = true
        TriggerEvent("mythic_progbar:client:progress", {
                name = "distillation",
                duration = 5000,
                label = "Établissement d'un mécanisme de distillation...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
         Citizen.Wait(5000)
        exports['mythic_notify']:SendAlert("inform", "Le processus de distillation sera terminé après 30 secondes")
        Citizen.Wait(30000)
        exports['mythic_notify']:SendAlert("inform", "Distillation terminée Retirez les bouteilles de la table")
        while distressBottle do
            Citizen.Wait(1)
        local playerPed = GetEntityCoords(PlayerPedId())
        local dst = GetDistanceBetweenCoords(playerPed, Config.kordinatlar.damitma.x, Config.kordinatlar.damitma.y, Config.kordinatlar.damitma.z, true)
        if dst <= 1 and distressBottle then
            DrawText3D( Config.kordinatlar.damitma.x, Config.kordinatlar.damitma.y, Config.kordinatlar.damitma.z+0.40, "~g~[E]~w~ Obtenez des bouteilles d'acétone distillée ~w~", 0.45)
            if IsControlJustPressed(0, 38) then
                TriggerEvent("mythic_progbar:client:progress", {
                name = "bouteilles",
                duration = 2500,
                label = "Obtenir des bouteilles...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "creatures@rottweiler@tricks@",
                    anim = "petting_franklin",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
         Citizen.Wait(2500)
                TriggerServerEvent("eff_meth:giveItem", "distilledbottle", 2)  
                distressBottle = false 
                Citizen.Wait(1500)
                isProcessing = false                        
            end
        end
    end    
end

-- StageThree //
function StageThree()
    isProcessing = true
    mixfosfor = true
        TriggerEvent("mythic_progbar:client:progress", {
                name = "melanger",
                duration = 5000,
                label = "Vous mettez de l'acétone et du phosphore dans le mélangeur...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@medic@standing@tendtodead@base",
                    anim = "base",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
         Citizen.Wait(5000)
        exports['mythic_notify']:SendAlert("inform", "Le processus de mélange sera terminé après 1 minute")
        Citizen.Wait(60000)
        exports['mythic_notify']:SendAlert("inform", "Le processus de mélange est terminé, vous pouvez obtenir le mélange")
        while mixfosfor do
            Citizen.Wait(1)
        local playerPed = GetEntityCoords(PlayerPedId())
        local dst = GetDistanceBetweenCoords(playerPed, Config.kordinatlar.fosfor.x, Config.kordinatlar.fosfor.y, Config.kordinatlar.fosfor.z, true)
        if dst <= 1 and mixfosfor then
            DrawText3D( Config.kordinatlar.fosfor.x, Config.kordinatlar.fosfor.y, Config.kordinatlar.fosfor.z+0.40, "~g~[E]~w~ Obtenez le mélange ~w~", 0.45)
            if IsControlJustPressed(0, 38) then
                TriggerEvent("mythic_progbar:client:progress", {
                name = "bottleone",
                duration = 2500,
                label = "Obtenir le mélange...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "creatures@rottweiler@tricks@",
                    anim = "petting_franklin",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
         Citizen.Wait(2500)
                TriggerServerEvent("eff_meth:giveItem", "mixedmeth", 1)  
                mixfosfor = false 
                Citizen.Wait(1500)
                isProcessing = false                       
            end
        end
    end    
end


function StageFour()
    isProcessing = true
    TriggerServerEvent("eff_meth:removeItem", "mixedmeth", 1)
        TriggerEvent("mythic_progbar:client:progress", {
                name = "acetone",
                duration = 10000,
                label = "Le matériau est versé dans le four...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end)      
        Citizen.Wait(10000)
        TriggerEvent("eff_meth:questionstwo")
end


RegisterNetEvent("eff_meth:questions")
AddEventHandler("eff_meth:questions", function()
    local miktar = math.random(100,500)
    local chance = nil
    if miktar >=100 and miktar <= 150 then
        chance = 5
    elseif miktar >=150 and miktar <= 200 then
        chance = 2
    elseif miktar >=200 and miktar <= 250 then
        chance = 4
    elseif miktar >=250 and miktar <= 300 then
        chance = 1
    elseif miktar >=300 and miktar <= 350 then
        chance = 3
    elseif miktar >=350 and miktar <= 400 then
        chance = 6
    elseif miktar >=450 and miktar <= 500 then
        chance = 7
    end
    ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'fosforquest', 
  {
    title    = (miktar.. Config.questions.title),
    align = 'center', 
    elements = { 
      {label = (Config.questions.steps[1].label),     value = Config.questions.steps[1].value},
      {label = (Config.questions.steps[2].label),     value = Config.questions.steps[2].value},
      {label = (Config.questions.steps[3].label),     value = Config.questions.steps[3].value},
      {label = (Config.questions.steps[4].label),     value = Config.questions.steps[4].value},
      {label = (Config.questions.steps[5].label),     value = Config.questions.steps[5].value},
      {label = (Config.questions.steps[6].label),     value = Config.questions.steps[6].value},
      {label = (Config.questions.steps[7].label),     value = Config.questions.steps[7].value},
    }
  },  function(data, menu) 
    if data.current.value == chance then
        menu.close()
        TriggerServerEvent("eff_meth:removeItem", "distilledbottle", 2)
        TriggerServerEvent("eff_meth:removeItem", "phosphorus", 2)
        StageThree()
    else
        menu.close() 
        TriggerServerEvent("eff_meth:removeItem", "distilledbottle", 2)
        TriggerServerEvent("eff_meth:removeItem", "phosphorus", 2)
        fakeStart()
    end   
  end,
  function(data, menu) 
      menu.close() 
  end)
end)

function fakeStart()
    isProcessing = true
    mixfosfor = true
        TriggerEvent("mythic_progbar:client:progress", {
                name = "melanger2",
                duration = 5000,
                label = "Vous mettez de l'acétone et du phosphore dans le mélangeur...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@medic@standing@tendtodead@base",
                    anim = "base",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
         Citizen.Wait(5000)
        exports['mythic_notify']:SendAlert("inform", "Le processus de mélange sera terminé après 1 minute")
        Citizen.Wait(60000)
        exports['mythic_notify']:SendAlert("inform", "Le processus de mélange est terminé, vous pouvez obtenir le mélange")
        while mixfosfor do
            Citizen.Wait(1)
        local playerPed = GetEntityCoords(PlayerPedId())
        local dst = GetDistanceBetweenCoords(playerPed, Config.kordinatlar.fosfor.x, Config.kordinatlar.fosfor.y, Config.kordinatlar.fosfor.z, true)
        if dst <= 1 and mixfosfor then
            DrawText3D( Config.kordinatlar.fosfor.x, Config.kordinatlar.fosfor.y, Config.kordinatlar.fosfor.z+0.40, "~g~[E]~w~ Obtenez le mélange ~w~", 0.45)
            if IsControlJustPressed(0, 38) then
                TriggerEvent("mythic_progbar:client:progress", {
                name = "fosfor",
                duration = 2500,
                label = "Obtenir le mélange...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "creatures@rottweiler@tricks@",
                    anim = "petting_franklin",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
         Citizen.Wait(2500)
                exports['mythic_notify']:SendAlert("error", "Impossible d'obtenir le paramètre...")
                Citizen.Wait(1000)
                animasyon(PlayerPedId(), "gestures@m@standing@casual", "gesture_damn")
                TriggerEvent("eff_meth:gasiscoming", true)
                mixfosfor = false 
                Citizen.Wait(1500)
                isProcessing = false                     
            end
        end
    end    
end


RegisterNetEvent("eff_meth:questionstwo")
AddEventHandler("eff_meth:questionstwo", function()
    isProcessing = true
    local player = PlayerPedId()
    exports['mythic_notify']:SendAlert("inform", "Le poêle a commencé à travailler à 450 degrés")
    Citizen.Wait(2000)
    exports['mythic_notify']:SendAlert("inform", "Tenez-vous devant le poêle et ajustez la qualité du matériau")
     TriggerEvent("mythic_progbar:client:progress", {
                name = "fusion",
                duration = 20000,
                label = "Cuisine...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "random@shop_tattoo",
                    anim = "_idle_a",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
    Citizen.Wait(20000)
    if isProcessing then
    ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'smelttwo', 
  {
    title    = (Config.questions.titletwo),
    align = 'center', 
    elements = { 
      {label = (Config.questions.stepstwo[1].label),     value = Config.questions.stepstwo[1].value},
      {label = (Config.questions.stepstwo[2].label),     value = Config.questions.stepstwo[2].value},
      {label = (Config.questions.stepstwo[3].label),     value = Config.questions.stepstwo[3].value},
    }
  },  function(data, menu) 
    if data.current.value == 1 then
        menu.close()
        ESX.TriggerServerCallback("eff_meth:checkItem", function(output)
            if output then
            TriggerServerEvent("eff_meth:removeItem", "aluminyum", 2)
            TriggerEvent("eff_meth:questionsthree")
            elseif not output then          
            exports['mythic_notify']:SendAlert("error", "Aucun aluminium imbécile!")
            TriggerEvent("eff_meth:stepone")
            TriggerEvent("eff_meth:questionsthree")
            end
            end, "aluminyum", 2)        
    else
        menu.close() 
       TriggerEvent("eff_meth:stepone")
       TriggerEvent("eff_meth:questionsthree")
    end   
  end,
  function(data, menu) 
      menu.close() 
  end)
end
end)

RegisterNetEvent("eff_meth:questionsthree")
AddEventHandler("eff_meth:questionsthree", function()
     TriggerEvent("mythic_progbar:client:progress", {
                name = "smeltingthree",
                duration = 20000,
                label = "Cuisine...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "random@shop_tattoo",
                    anim = "_idle_a",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
    Citizen.Wait(20000)
    if isProcessing then
    ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'smeltthree', 
  {
    title    = (Config.questions.titlethree),
    align = 'center', 
    elements = { 
      {label = (Config.questions.stepsthree[1].label),     value = Config.questions.stepsthree[1].value},
      {label = (Config.questions.stepsthree[2].label),     value = Config.questions.stepsthree[2].value},
      {label = (Config.questions.stepsthree[3].label),     value = Config.questions.stepsthree[3].value},
    }
  },  function(data, menu) 
    if data.current.value == 2 then
        menu.close() 
      TriggerEvent("eff_meth:questionsfour")
    else
        menu.close() 
       TriggerEvent("eff_meth:stepone")
       TriggerEvent("eff_meth:questionsfour")
    end   
  end,
  function(data, menu) 
      menu.close() 
  end)
end
end)

RegisterNetEvent("eff_meth:questionsfour")
AddEventHandler("eff_meth:questionsfour", function()
     TriggerEvent("mythic_progbar:client:progress", {
                name = "smeltingfour",
                duration = 20000,
                label = "Cuisine...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "random@shop_tattoo",
                    anim = "_idle_a",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
    Citizen.Wait(20000)
    if isProcessing then
    ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'smeltfour', 
  {
    title    = (Config.questions.titlefour),
    align = 'center', 
    elements = { 
      {label = (Config.questions.stepsfour[1].label),     value = Config.questions.stepsfour[1].value},
      {label = (Config.questions.stepsfour[2].label),     value = Config.questions.stepsfour[2].value},
      {label = (Config.questions.stepsfour[3].label),     value = Config.questions.stepsfour[3].value},
    }
  },  function(data, menu) 
    if data.current.value == 3 then
        menu.close() 
         TriggerEvent("mythic_progbar:client:progress", {
                name = "smeltingfour",
                duration = 20000,
                label = "Cuisine...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "random@shop_tattoo",
                    anim = "_idle_a",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
         Citizen.Wait(20000)
        isProcessing = false
        TriggerEvent("eff_meth:succes")
    else
        menu.close() 
                 TriggerEvent("mythic_progbar:client:progress", {
                name = "smeltingfour",
                duration = 20000,
                label = "Cuisine...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "random@shop_tattoo",
                    anim = "_idle_a",
                 },
                prop = {
                    -- model = "p_cs_script_bottle_s",
                 }
             }, function(status)
              if not status then
               end
         end) 
         Citizen.Wait(20000)
        isProcessing = false
        TriggerEvent("eff_meth:succes")  
    end   
  end,
  function(data, menu) 
      menu.close() 
  end)
end
end)

RegisterNetEvent("eff_meth:stepone")
AddEventHandler("eff_meth:stepone", function()
    sayac = sayac + 1
end)


RegisterNetEvent("eff_meth:succes")
AddEventHandler("eff_meth:succes", function()
    if sayac == 0 then
        TriggerServerEvent("eff_meth:giveItem", "meth", 6)
    elseif sayac == 1 then
        TriggerServerEvent("eff_meth:giveItem", "meth", 4)
    elseif sayac == 2 then
        TriggerServerEvent("eff_meth:giveItem", "meth", 2)
    elseif sayac == 3 then
        exports['mythic_notify']:SendAlert("error", "La qualité du matériau a l'air terrible, cela ne vaut rien..")
    end
end)

RegisterCommand('methiptal', function()
TriggerEvent("eff_meth:break", false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1) 
        local sleep = 1000
        local player = PlayerPedId()
        if IsEntityDead(player) or not DoesEntityExist(player) then
		if isProcessing then
            exports['mythic_notify']:SendAlert("error", "Tous vos biens gaspillés pour votre mort..")
            TriggerEvent("eff_meth:break", false)
		end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent("eff_meth:break")
AddEventHandler("eff_meth:break", function(durum)
isProcessing = durum
FreezeEntityPosition(PlayerPedId(), false)
ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("eff_meth:gasiscoming")
AddEventHandler("eff_meth:gasiscoming", function(startGas)
    while true do   
        inGas = startGas
        Citizen.Wait(1)
        local sleep = 1000
        local gasCenter = vector3(1393.36,3606.99,38.94)
        local player = PlayerPedId()
        local playerCoord = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playerCoord, gasCenter, true)
        RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(10)
        end
        if inGas == true then
            sleep = 0
            SetPtfxAssetNextCall("core")
            Gas = StartNetworkedParticleFxNonLoopedAtCoord("veh_respray_smoke", gasCenter, 0.0, 0.0, 0.0, 0.80, false, false, false, false)          
            Citizen.Wait(10000)
            exports['mythic_notify']:SendAlert("error", "Le gaz du mélangeur a endommagé les poumons..")
            startGas = false 
            ApplyDamageToPed(player, 10, true)
            StopParticleFxLooped(Gas, 0)          
        end       
        Citizen.Wait(sleep)
    end
end)



-- 3D text lieu de traction //
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 140)
end

-- Envoyer la fonction d'animation //
function animasyon(ped, ad, anim)  -- échantillon // animation(playerPed, "mp_common", "givetake1_a")
	ESX.Streaming.RequestAnimDict(ad, function()
		TaskPlayAnim(ped, ad, anim, 8.0, -8.0, -1, 0, 0, 0, 0, 0)
	end)
end
