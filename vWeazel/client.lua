ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)


Citizen.CreateThread(function()
    if Weazel.jeveuxblips then
    local weazelmap = AddBlipForCoord(Weazel.pos.blips.position.x, Weazel.pos.blips.position.y, Weazel.pos.blips.position.z)
    SetBlipSprite(weazelmap, 184)
    SetBlipColour(weazelmap, 1)
    SetBlipScale(weazelmap, 0.65)
    SetBlipAsShortRange(weazelmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Weazel News")
    EndTextCommandSetBlipName(weazelmap)
    end
end)

function Menuf6Weazel()
    local vWeazel6 = RageUI.CreateMenu("Weazel News", "Interactions")
    vWeazel6:SetRectangleBanner(255, 0, 0)
    RageUI.Visible(vWeazel6, not RageUI.Visible(vWeazel6))
    while vWeazel6 do
        Citizen.Wait(0)
            RageUI.IsVisible(vWeazel6, true, true, true, function()

                RageUI.Separator("↓ Camera/Micro ↓")

                RageUI.ButtonWithStyle("Sortir/Rentrer Camera",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand('cam')
                        RageUI.CloseAll()
                    end
                end)

                RageUI.ButtonWithStyle("Sortir/Rentrer Micro",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand('mic')
                        RageUI.CloseAll()
                    end
                end)


                RageUI.Separator("↓ Facture ↓")

                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_weazel', ('Weazel News'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)


                RageUI.Separator("↓ Annonce ↓")



                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('vWeazel:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('vWeazel:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('vWeazel:Perso', msg)
                    end
                end)
                end, function() 
                end)
    
                if not RageUI.Visible(vWeazel6) then
                    vWeazel6 = RMenu:DeleteType("Weazel News", true)
        end
    end
end

Keys.Register('F6', 'weazel', 'Ouvrir le menu Weazel News', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weazel' then
    	Menuf6Weazel()
	end
end)

function CoffreWeazel()
    local Cweazel = RageUI.CreateMenu("Coffre", "Weazel News")
    Cweazel:SetRectangleBanner(255, 0, 0)
        RageUI.Visible(Cweazel, not RageUI.Visible(Cweazel))
            while Cweazel do
            Citizen.Wait(0)
            RageUI.IsVisible(Cweazel, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            WeazelRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            WeazelDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cweazel) then
            Cweazel = RMenu:DeleteType("Cweazel", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weazel' then
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Weazel.pos.coffre.position.x, Weazel.pos.coffre.position.y, Weazel.pos.coffre.position.z)
            if jobdist <= 10.0 and Weazel.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Weazel.pos.coffre.position.x, Weazel.pos.coffre.position.y, Weazel.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreWeazel()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)


-- Garage

function GarageWeazel()
  local GWeazel = RageUI.CreateMenu("Garage", "Weazel News")
  GWeazel:SetRectangleBanner(255, 0, 0)
    RageUI.Visible(GWeazel, not RageUI.Visible(GWeazel))
        while GWeazel do
            Citizen.Wait(0)
                RageUI.IsVisible(GWeazel, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GWeazelvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarWeazel(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GWeazel) then
            GWeazel = RMenu:DeleteType("Garage", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weazel' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Weazel.pos.garage.position.x, Weazel.pos.garage.position.y, Weazel.pos.garage.position.z)
            if dist3 <= 10.0 and Weazel.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Weazel.pos.garage.position.x, Weazel.pos.garage.position.y, Weazel.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageWeazel()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarWeazel(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Weazel.pos.spawnvoiture.position.x, Weazel.pos.spawnvoiture.position.y, Weazel.pos.spawnvoiture.position.z, Weazel.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Weazel News"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end

--------Garage Helico

-- Garage

function GarageHelicoWeazel()
    local GHWeazel = RageUI.CreateMenu("Garage Helico", "Weazel News")
    GHWeazel:SetRectangleBanner(255, 0, 0)
      RageUI.Visible(GHWeazel, not RageUI.Visible(GHWeazel))
          while GHWeazel do
              Citizen.Wait(0)
                  RageUI.IsVisible(GHWeazel, true, true, true, function()
                      RageUI.ButtonWithStyle("Ranger l'helico", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then   
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              RageUI.CloseAll()
                              end 
                          end
                      end) 
  
                      for k,v in pairs(GHWeazelHelico) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Citizen.Wait(1)  
                              spawnuniCarWeazelHelico(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(GHWeazel) then
              GHWeazel = RMenu:DeleteType("Garage Helico", true)
          end
      end
  end
  
  Citizen.CreateThread(function()
          while true do
              local Timer = 500
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'weazel' then
              local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
              local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Weazel.pos.garagehelico.position.x, Weazel.pos.garagehelico.position.y, Weazel.pos.garagehelico.position.z)
              if dist3 <= 10.0 and Weazel.jeveuxmarker then
                  Timer = 0
                  DrawMarker(20, Weazel.pos.garagehelico.position.x, Weazel.pos.garagehelico.position.y, Weazel.pos.garagehelico.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                  end
                  if dist3 <= 3.0 then
                  Timer = 0   
                      RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage a helico", time_display = 1 })
                      if IsControlJustPressed(1,51) then           
                          GarageHelicoWeazel()
                      end   
                  end
              end 
          Citizen.Wait(Timer)
       end
  end)
  
  function spawnuniCarWeazelHelico(car)
      local car = GetHashKey(car)
  
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Citizen.Wait(0)
      end
  
      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
      local vehicle = CreateVehicle(car, Weazel.pos.spawnhelico.position.x, Weazel.pos.spawnhelico.position.y, Weazel.pos.spawnhelico.position.z, Weazel.pos.spawnhelico.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "Weazel News"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
  end



itemstock = {}
function WeazelRetirerobjet()
    local StockWeazel = RageUI.CreateMenu("Coffre", "Weazel News")
    StockWeazel:SetRectangleBanner(255, 0, 0)
    ESX.TriggerServerCallback('vWeazel:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(StockWeazel, not RageUI.Visible(StockWeazel))
        while StockWeazel do
            Citizen.Wait(0)
                RageUI.IsVisible(StockWeazel, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('vWeazel:getStockItem', v.name, tonumber(count))
                                    WeazelRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockWeazel) then
            StockWeazel = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function WeazelDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Weazel News")
    StockPlayer:SetRectangleBanner(255, 0, 0)
    ESX.TriggerServerCallback('vWeazel:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('vWeazel:putStockItems', item.name, tonumber(count))
                                            WeazelDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end