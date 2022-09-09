ESX = exports["es_extended"]:getSharedObject()
local iswearingsuit = false
local oxgenlevell = 0
local currentGear = {
    mask = 0,
    tank = 0,
    oxygen = 0,
    enabled = false
}
currentGear.oxygen = 0
-- Functions
local function deleteGear()
	if currentGear.mask ~= 0 then
        DetachEntity(currentGear.mask, 0, 1)
        DeleteEntity(currentGear.mask)
		currentGear.mask = 0
    end
	if currentGear.tank ~= 0 then
        DetachEntity(currentGear.tank, 0, 1)
        DeleteEntity(currentGear.tank)
		currentGear.tank = 0
	end
    currentGear.oxygen = 0
end
local function gearAnim()
    RequestAnimDict("clothingshirt")
    while not HasAnimDictLoaded("clothingshirt") do
        Wait(0)
    end
	TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end
RegisterNetEvent("qb-diving:client:setoxygenlevel", function()
    if currentGear.oxygen == 0 then
       oxgenlevell = 100 -- oxygenlevel
     --  QBCore.Functions.Notify('The tube has been filled successfully', 'success')
    else
       -- QBCore.Functions.Notify('the gear level is'..' '..currentGear.oxygen..' '..'must be 0%', 'error')
    end
end)
function DrawText2(text)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextScale(0.0, 0.45)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.45, 0.90)
end
RegisterNetEvent('qb-diving:client:UseGear', function(bool)
    local ped = PlayerPedId()
    if iswearingsuit == false then
        if oxgenlevell > 0 then
            iswearingsuit = true
            if not IsPedSwimming(ped) and not IsPedInAnyVehicle(ped) then
                gearAnim()
                      --  QBCore.Functions.Progressbar("equip_gear", Lang:t("info.put_suit"), 5000, false, true, {}, {}, {}, {}, function() -- Done
                            deleteGear()
                            local maskModel = `p_d_scuba_mask_s`
                            local tankModel = `p_s_scuba_tank_s`
                            RequestModel(tankModel)
                            while not HasModelLoaded(tankModel) do
                                Wait(0)
                            end
                            currentGear.tank = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
                            local bone1 = GetPedBoneIndex(ped, 24818)
                            AttachEntityToEntity(currentGear.tank, ped, bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
                            
                            RequestModel(maskModel)
                            while not HasModelLoaded(maskModel) do
                                Wait(0)
                            end
                            currentGear.mask = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
                            local bone2 = GetPedBoneIndex(ped, 12844)
                            AttachEntityToEntity(currentGear.mask, ped, bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
                            SetEnableScuba(ped, true)
                            SetPedMaxTimeUnderwater(ped, 2000.00)
                            currentGear.enabled = true
                            ClearPedTasks(ped)
                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                            oxgenlevell = oxgenlevell
                            Citizen.CreateThread(function()
                                while currentGear.enabled do
                                    if IsPedSwimmingUnderWater(PlayerPedId()) then
                                        oxgenlevell = oxgenlevell - 1
                                        local playerCoords = GetEntityCoords(PlayerPedId())
                                        local headingplayer = GetEntityHeading(PlayerPedId())
                                    if oxgenlevell == 90 then
                                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 80 then
                                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 70 then
                                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 60 then
                                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 50 then
                                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 40 then
                                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 30 then
                                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 20 then
                                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 10 then
                                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "breathdivingsuit", 0.25)
                                    elseif oxgenlevell == 0 then
                                            deleteGear()
                                            SetEnableScuba(ped, false)
                                            SetPedMaxTimeUnderwater(ped, 1.00)
                                            currentGear.enabled = false
                                            iswearingsuit = false
                                            TriggerServerEvent("InteractSound_SV:PlayOnSource", nil, 0.25)
                                        end
                                    end
                                    Wait(1000)
                                end
                            end)
                      --  end)
                    else
                   -- QBCore.Functions.Notify(Lang:t("error.not_standing_up"), 'error')
                end
            else
               -- QBCore.Functions.Notify('you need oxygen tube', 'error')
            end
    elseif iswearingsuit == true then
                gearAnim()
              --  QBCore.Functions.Progressbar("remove_gear", Lang:t("info.pullout_suit"), 5000, false, true, {}, {}, {}, {}, function() -- Done
                    SetEnableScuba(ped, false)
                    SetPedMaxTimeUnderwater(ped, 50.00)
                    currentGear.enabled = false
                    ClearPedTasks(ped)
                    deleteGear()
                  --  QBCore.Functions.Notify(Lang:t("success.took_out"))
                    TriggerServerEvent("InteractSound_SV:PlayOnSource", nil, 0.25)
                    iswearingsuit = false
                    oxgenlevell = oxgenlevell
               -- end)
    end
end)
-- Threads
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
      if currentGear.enabled == true and iswearingsuit == true then
        if IsPedSwimmingUnderWater(PlayerPedId()) then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local headingplayer = GetEntityHeading(PlayerPedId())
             DrawText2(oxgenlevell..'⏱')
        end
     end
    end
end)