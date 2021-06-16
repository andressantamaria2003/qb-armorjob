QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local Plates = {}
cuffedPlayers = {}
PlayerStatus = {}
Casings = {}
BloodDrops = {}
FingerDrops = {}
local Objects = {}


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("armor:SetCopCount", -1, curCops)
    end
end)

-- RegisterServerEvent('armor:server:CheckBills')
-- AddEventHandler('armor:server:CheckBills', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     QBCore.Functions.ExecuteSql(false, "SELECT * FROM `bills` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `type` = 'armor'", function(result)
--         if result[1] ~= nil then
--             local totalAmount = 0
-- 			for k, v in pairs(result) do
-- 				totalAmount = totalAmount + tonumber(v.amount)
--             end
--             Player.Functions.RemoveMoney("bank", totalAmount, "paid-all-bills")
--             QBCore.Functions.ExecuteSql(false, "DELETE FROM `bills` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `type` = 'armor'")
--             TriggerClientEvent('armor:client:sendBillingMail', src, totalAmount)
--             TriggerEvent('qb-moneysafe:server:DepositMoney', "armor", totalAmount, "bills")
-- 		end
-- 	end)
-- end)

-- RegisterServerEvent('armor:server:TakeOutImpound')
-- AddEventHandler('armor:server:TakeOutImpound', function(plate)
--     local src = source       
--     exports['ghmattimysql']:execute('UPDATE player_vehicles SET state = @state WHERE plate = @plate', {['@state'] = 0, ['@plate'] = plate})
--     TriggerClientEvent('QBCore:Notify', src, "Vehicle is taken out of Impound!")  
-- end)

-- RegisterServerEvent('armor:server:CuffPlayer')
-- AddEventHandler('armor:server:CuffPlayer', function(playerId, isSoftcuff)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(source)
--     local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
--     if CuffedPlayer ~= nil then
--         if Player.Functions.GetItemByName("handcuffs") ~= nil or Player.PlayerData.job.name == "armor" then
--             TriggerClientEvent("armor:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source, isSoftcuff)           
--         end
--     end
-- end)

-- RegisterServerEvent('armor:server:EscortPlayer')
-- AddEventHandler('armor:server:EscortPlayer', function(playerId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(source)
--     local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
--     if EscortPlayer ~= nil then
--         if (Player.PlayerData.job.name == "armor" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") or (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
--             TriggerClientEvent("armor:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
--         else
--             TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Person is not dead or cuffed!")
--         end
--     end
-- end)

-- RegisterServerEvent('armor:server:KidnapPlayer')
-- AddEventHandler('armor:server:KidnapPlayer', function(playerId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(source)
--     local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
--     if EscortPlayer ~= nil then
--         if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"] then
--             TriggerClientEvent("armor:client:GetKidnappedTarget", EscortPlayer.PlayerData.source, Player.PlayerData.source)
--             TriggerClientEvent("armor:client:GetKidnappedDragger", Player.PlayerData.source, EscortPlayer.PlayerData.source)
--         else
--             TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Person is not dead or cuffed!")
--         end
--     end
-- end)

-- RegisterServerEvent('armor:server:SetPlayerOutVehicle')
-- AddEventHandler('armor:server:SetPlayerOutVehicle', function(playerId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(source)
--     local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
--     if EscortPlayer ~= nil then
--         if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
--             TriggerClientEvent("armor:client:SetOutVehicle", EscortPlayer.PlayerData.source)
--         else
--             TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Person is not dead or cuffed!")
--         end
--     end
-- end)

-- RegisterServerEvent('armor:server:PutPlayerInVehicle')
-- AddEventHandler('armor:server:PutPlayerInVehicle', function(playerId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(source)
--     local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
--     if EscortPlayer ~= nil then
--         if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
--             TriggerClientEvent("armor:client:PutInVehicle", EscortPlayer.PlayerData.source)
--         else
--             TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Person is not dead or cuffed!")
--         end
--     end
-- end)

RegisterServerEvent('armor:server:BillPlayer')
AddEventHandler('armor:server:BillPlayer', function(playerId, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "armor" then
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
            TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, "You received a fine of $"..price)
        end
    end
end)

-- RegisterServerEvent('armor:server:JailPlayer')
-- AddEventHandler('armor:server:JailPlayer', function(playerId, time)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
--     local currentDate = os.date("*t")
--     if currentDate.day == 31 then currentDate.day = 30 end

--     if Player.PlayerData.job.name == "armor" then
--         if OtherPlayer ~= nil then
--             OtherPlayer.Functions.SetMetaData("injail", time)
--             OtherPlayer.Functions.SetMetaData("criminalrecord", {
--                 ["hasRecord"] = true,
--                 ["date"] = currentDate
--             })
--             TriggerClientEvent("armor:client:SendToJail", OtherPlayer.PlayerData.source, time)
--             TriggerClientEvent('QBCore:Notify', src, "You sent the person to prison for "..time.." months")
--         end
--     end
-- end)

-- RegisterServerEvent('armor:server:SetHandcuffStatus')
-- AddEventHandler('armor:server:SetHandcuffStatus', function(isHandcuffed)
-- 	local src = source
-- 	local Player = QBCore.Functions.GetPlayer(src)
-- 	if Player ~= nil then
-- 		Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
-- 	end
-- end)

-- RegisterServerEvent('heli:spotlight')
-- AddEventHandler('heli:spotlight', function(state)
-- 	local serverID = source
-- 	TriggerClientEvent('heli:spotlight', -1, serverID, state)
-- end)

-- RegisterServerEvent('armor:server:FlaggedPlateTriggered')
-- AddEventHandler('armor:server:FlaggedPlateTriggered', function(camId, plate, street1, street2, blipSettings)
--     local src = source
--     for k, v in pairs(QBCore.Functions.GetPlayers()) do
--         local Player = QBCore.Functions.GetPlayer(v)
--         if Player ~= nil then
--             if (Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty) then
--                 if street2 ~= nil then
--                     TriggerClientEvent("112:client:SendarmorAlert", v, "flagged", {
--                         camId = camId,
--                         plate = plate,
--                         streetLabel = street1.. " "..street2,
--                     }, blipSettings)
--                 else
--                     TriggerClientEvent("112:client:SendarmorAlert", v, "flagged", {
--                         camId = camId,
--                         plate = plate,
--                         streetLabel = street1
--                     }, blipSettings)
--                 end
--             end
--         end
-- 	end
-- end)

-- RegisterServerEvent('armor:server:armorAlertMessage')
-- AddEventHandler('armor:server:armorAlertMessage', function(title, streetLabel, coords)
--     local src = source

--     for k, v in pairs(QBCore.Functions.GetPlayers()) do
--         local Player = QBCore.Functions.GetPlayer(v)
--         if Player ~= nil then 
--             if (Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty) then
--                 TriggerClientEvent("armor:client:armorAlertMessage", v, title, streetLabel, coords)
--             elseif Player.Functions.GetItemByName("radioscanner") ~= nil and math.random(1, 100) <= 50 then
--                 TriggerClientEvent("armor:client:armorAlertMessage", v, title, streetLabel, coords)
--             end
--         end
--     end
-- end)

-- RegisterServerEvent('armor:server:GunshotAlert')
-- AddEventHandler('armor:server:GunshotAlert', function(streetLabel, isAutomatic, fromVehicle, coords, vehicleInfo)
--     local src = source

--     for k, v in pairs(QBCore.Functions.GetPlayers()) do
--         local Player = QBCore.Functions.GetPlayer(v)
--         if Player ~= nil then 
--             if (Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty) then
--                 TriggerClientEvent("armor:client:GunShotAlert", Player.PlayerData.source, streetLabel, isAutomatic, fromVehicle, coords, vehicleInfo)
--             elseif Player.Functions.GetItemByName("radioscanner") ~= nil and math.random(1, 100) <= 50 then
--                 TriggerClientEvent("armor:client:GunShotAlert", Player.PlayerData.source, streetLabel, isAutomatic, fromVehicle, coords, vehicleInfo)
--             end
--         end
--     end
-- end)

-- RegisterServerEvent('armor:server:VehicleCall')
-- AddEventHandler('armor:server:VehicleCall', function(pos, msg, alertTitle, streetLabel, modelPlate, modelName)
--     local src = source
--     local alertData = {
--         title = "Vehicle theft",
--         coords = {x = pos.x, y = pos.y, z = pos.z},
--         description = msg,
--     }
--     TriggerClientEvent("armor:client:VehicleCall", -1, pos, alertTitle, streetLabel, modelPlate, modelName)
--     TriggerClientEvent("qb-phone:client:addarmorAlert", -1, alertData)
-- end)

-- RegisterServerEvent('armor:server:HouseRobberyCall')
-- AddEventHandler('armor:server:HouseRobberyCall', function(coords, message, gender, streetLabel)
--     local src = source
--     local alertData = {
--         title = "Burglary",
--         coords = {x = coords.x, y = coords.y, z = coords.z},
--         description = message,
--     }
--     TriggerClientEvent("armor:client:HouseRobberyCall", -1, coords, message, gender, streetLabel)
--     TriggerClientEvent("qb-phone:client:addarmorAlert", -1, alertData)
-- end)

-- RegisterServerEvent('armor:server:SendEmergencyMessage')
-- AddEventHandler('armor:server:SendEmergencyMessage', function(coords, message)
--     local src = source
--     local MainPlayer = QBCore.Functions.GetPlayer(src)
--     local alertData = {
--         title = "911 alert - "..MainPlayer.PlayerData.charinfo.firstname .. " " .. MainPlayer.PlayerData.charinfo.lastname .. " ("..src..")",
--         coords = {x = coords.x, y = coords.y, z = coords.z},
--         description = message,
--     }
--     TriggerClientEvent("qb-phone:client:addarmorAlert", -1, alertData)
--     TriggerClientEvent('armor:server:SendEmergencyMessageCheck', -1, MainPlayer, message, coords)
-- end)

-- RegisterServerEvent('armor:server:SearchPlayer')
-- AddEventHandler('armor:server:SearchPlayer', function(playerId)
--     local src = source
--     local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
--     if SearchedPlayer ~= nil then 
--         TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "Person has $"..SearchedPlayer.PlayerData.money["cash"]..",- on him..")
--         TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You are being searched..")
--     end
-- end)

-- RegisterServerEvent('armor:server:SeizeCash')
-- AddEventHandler('armor:server:SeizeCash', function(playerId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
--     if SearchedPlayer ~= nil then 
--         local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
--         local info = {
--             cash = moneyAmount,
--         }
--         SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "armor-cash-seized")
--         Player.Functions.AddItem("moneybag", 1, false, info)
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["moneybag"], "add")
--         TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Your cash is confiscated..")
--     end
-- end)

-- RegisterServerEvent('armor:server:SeizeDriverLicense')
-- AddEventHandler('armor:server:SeizeDriverLicense', function(playerId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
--     if SearchedPlayer ~= nil then
--         local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
--         if driverLicense then
--             local licenses = {
--                 ["driver"] = false,
--                 ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]
--             }
--             SearchedPlayer.Functions.SetMetaData("licences", licenses)
--             TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Your driving license has been confiscated..")
--         else
--             TriggerClientEvent('QBCore:Notify', src, "Can't confiscate driving license..", "error")
--         end
--     end
-- end)

-- RegisterServerEvent('armor:server:RobPlayer')
-- AddEventHandler('armor:server:RobPlayer', function(playerId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
--     if SearchedPlayer ~= nil then 
--         local money = SearchedPlayer.PlayerData.money["cash"]
--         Player.Functions.AddMoney("cash", money, "armor-player-robbed")
--         SearchedPlayer.Functions.RemoveMoney("cash", money, "armor-player-robbed")
--         TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have been robbed of $"..money.."..")
--     end
-- end)

-- RegisterServerEvent('armor:server:UpdateBlips')
-- AddEventHandler('armor:server:UpdateBlips', function()
--     local src = source
--     local dutyPlayers = {}
--     for k, v in pairs(QBCore.Functions.GetPlayers()) do
--         local Player = QBCore.Functions.GetPlayer(v)
--         if Player ~= nil then 
--             if ((Player.PlayerData.job.name == "armor" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
--                 table.insert(dutyPlayers, {
--                     source = Player.PlayerData.source,
--                     label = Player.PlayerData.metadata["callsign"],
--                     job = Player.PlayerData.job.name,
--                 })
--             end
--         end
--     end
--     TriggerClientEvent("armor:client:UpdateBlips", -1, dutyPlayers)
-- end)

-- RegisterServerEvent('armor:server:spawnObject')
-- AddEventHandler('armor:server:spawnObject', function(type)
--     local src = source
--     local objectId = CreateObjectId()
--     Objects[objectId] = type
--     TriggerClientEvent("armor:client:spawnObject", -1, objectId, type, src)
-- end)

-- RegisterServerEvent('armor:server:deleteObject')
-- AddEventHandler('armor:server:deleteObject', function(objectId)
--     local src = source
--     TriggerClientEvent('armor:client:removeObject', -1, objectId)
-- end)

-- RegisterServerEvent('armor:server:Impound')
-- AddEventHandler('armor:server:Impound', function(plate, fullImpound, price)
--     local src = source
--     local price = price ~= nil and price or 0
--     if IsVehicleOwned(plate) then
--         if not fullImpound then
--             exports['ghmattimysql']:execute('UPDATE player_vehicles SET state = @state, depotprice = @depotprice WHERE plate = @plate', {['@state'] = 0, ['@depotprice'] = price, ['@plate'] = plate})
--             TriggerClientEvent('QBCore:Notify', src, "Vehicle taken into depot for $"..price.."!")
--         else
--             exports['ghmattimysql']:execute('UPDATE player_vehicles SET state = @state WHERE plate = @plate', {['@state'] = 2, ['@plate'] = plate})
--             TriggerClientEvent('QBCore:Notify', src, "Vehicle completely seized!")
--         end
--     end
-- end)

RegisterServerEvent('evidence:server:UpdateStatus')
AddEventHandler('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

-- RegisterServerEvent('evidence:server:CreateBloodDrop')
-- AddEventHandler('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
--     local src = source
--     local bloodId = CreateBloodId()
--     BloodDrops[bloodId] = {dna = citizenid, bloodtype = bloodtype}
--     TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
-- end)

RegisterServerEvent('evidence:server:CreateFingerDrop')
AddEventHandler('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterServerEvent('evidence:server:ClearBlooddrops')
AddEventHandler('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList ~= nil and next(blooddropList) ~= nil then 
        for k, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterServerEvent('evidence:server:AddBlooddropToInventory')
AddEventHandler('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterServerEvent('evidence:server:AddFingerprintToInventory')
AddEventHandler('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

-- RegisterServerEvent('evidence:server:CreateCasing')
-- AddEventHandler('evidence:server:CreateCasing', function(weapon, coords)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local casingId = CreateCasingId()
--     local weaponInfo = QBCore.Shared.Weapons[weapon]
--     local serieNumber = nil
--     if weaponInfo ~= nil then 
--         local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
--         if weaponItem ~= nil then
--             if weaponItem.info ~= nil and  weaponItem.info ~= "" then 
--                 serieNumber = weaponItem.info.serie
--             end
--         end
--     end
--     TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
-- end)


RegisterServerEvent('armor:server:UpdateCurrentCops')
AddEventHandler('armor:server:UpdateCurrentCops', function()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    TriggerClientEvent("armor:SetCopCount", -1, amount)
end)

-- RegisterServerEvent('evidence:server:ClearCasings')
-- AddEventHandler('evidence:server:ClearCasings', function(casingList)
--     if casingList ~= nil and next(casingList) ~= nil then 
--         for k, v in pairs(casingList) do
--             TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
--             Casings[v] = nil
--         end
--     end
-- end)

-- RegisterServerEvent('evidence:server:AddCasingToInventory')
-- AddEventHandler('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
--         if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
--             TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
--             TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
--             Casings[casingId] = nil
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
--     end
-- end)

-- RegisterServerEvent('armor:server:showFingerprint')
-- AddEventHandler('armor:server:showFingerprint', function(playerId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(playerId)

--     TriggerClientEvent('armor:client:showFingerprint', playerId, src)
--     TriggerClientEvent('armor:client:showFingerprint', src, playerId)
-- end)

-- RegisterServerEvent('armor:server:showFingerprintId')
-- AddEventHandler('armor:server:showFingerprintId', function(sessionId)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local fid = Player.PlayerData.metadata["fingerprint"]

--     TriggerClientEvent('armor:client:showFingerprintId', sessionId, fid)
--     TriggerClientEvent('armor:client:showFingerprintId', src, fid)
-- end)

-- RegisterServerEvent('armor:server:SetTracker')
-- AddEventHandler('armor:server:SetTracker', function(targetId)
--     local Target = QBCore.Functions.GetPlayer(targetId)
--     local TrackerMeta = Target.PlayerData.metadata["tracker"]

--     if TrackerMeta then
--         Target.Functions.SetMetaData("tracker", false)
--         TriggerClientEvent('QBCore:Notify', targetId, 'Your anklet is taken off.', 'error', 5000)
--         TriggerClientEvent('QBCore:Notify', source, 'You took off an ankle bracelet from '..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, 'error', 5000)
--         TriggerClientEvent('armor:client:SetTracker', targetId, false)
--     else
--         Target.Functions.SetMetaData("tracker", true)
--         TriggerClientEvent('QBCore:Notify', targetId, 'You put on an ankle strap.', 'error', 5000)
--         TriggerClientEvent('QBCore:Notify', source, 'You put on an ankle strap to '..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, 'error', 5000)
--         TriggerClientEvent('armor:client:SetTracker', targetId, true)
--     end
-- end)

-- RegisterServerEvent('armor:server:SendTrackerLocation')
-- AddEventHandler('armor:server:SendTrackerLocation', function(coords, requestId)
--     local Target = QBCore.Functions.GetPlayer(source)
--     local TrackerMeta = Target.PlayerData.metadata["tracker"]

--     local msg = "The location of "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname.." is marked on your map."

--     local alertData = {
--         title = "Anklet location",
--         coords = {x = coords.x, y = coords.y, z = coords.z},
--         description = msg
--     }

--     TriggerClientEvent("armor:client:TrackerMessage", requestId, msg, coords)
--     TriggerClientEvent("qb-phone:client:addarmorAlert", requestId, alertData)
-- end)

-- RegisterServerEvent('armor:server:SendarmorEmergencyAlert')
-- AddEventHandler('armor:server:SendarmorEmergencyAlert', function(streetLabel, coords, callsign)
--     local alertData = {
--         title = "Assistance colleague",
--         coords = {x = coords.x, y = coords.y, z = coords.z},
--         description = "Emergency button pressed by ".. callsign .. " at "..streetLabel,
--     }
--     TriggerClientEvent("armor:client:armorEmergencyAlert", -1, callsign, streetLabel, coords)
--     TriggerClientEvent("qb-phone:client:addarmorAlert", -1, alertData)
-- end)

-- QBCore.Functions.CreateCallback('armor:server:isPlayerDead', function(source, cb, playerId)
--     local Player = QBCore.Functions.GetPlayer(playerId)
--     cb(Player.PlayerData.metadata["isdead"])
-- end)

-- QBCore.Functions.CreateCallback('armor:GetPlayerStatus', function(source, cb, playerId)
--     local Player = QBCore.Functions.GetPlayer(playerId)
--     local statList = {}
-- 	if Player ~= nil then
--         if PlayerStatus[Player.PlayerData.source] ~= nil and next(PlayerStatus[Player.PlayerData.source]) ~= nil then
--             for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
--                 table.insert(statList, PlayerStatus[Player.PlayerData.source][k].text)
--             end
--         end
-- 	end
--     cb(statList)
-- end)

-- QBCore.Functions.CreateCallback('armor:IsSilencedWeapon', function(source, cb, weapon)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local itemInfo = Player.Functions.GetItemByName(QBCore.Shared.Weapons[weapon]["name"])
--     local retval = false
--     if itemInfo ~= nil then 
--         if itemInfo.info ~= nil and itemInfo.info.attachments ~= nil then 
--             for k, v in pairs(itemInfo.info.attachments) do
--                 if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
--                     retval = true
--                 end
--             end
--         end
--     end
--     cb(retval)
-- end)

-- QBCore.Functions.CreateCallback('armor:GetDutyPlayers', function(source, cb)
--     local dutyPlayers = {}
--     for k, v in pairs(QBCore.Functions.GetPlayers()) do
--         local Player = QBCore.Functions.GetPlayer(v)
--         if Player ~= nil then 
--             if ((Player.PlayerData.job.name == "armor" or Player.PlayerData.job.name == "ambulance") and Player.PlayerData.job.onduty) then
--                 table.insert(dutyPlayers, {
--                     source = Player.PlayerData.source,
--                     label = Player.PlayerData.metadata["callsign"],
--                     job = Player.PlayerData.job.name,
--                 })
--             end
--         end
--     end
--     cb(dutyPlayers)
-- end)

-- function CreateBloodId()
--     if BloodDrops ~= nil then
-- 		local bloodId = math.random(10000, 99999)
-- 		while BloodDrops[caseId] ~= nil do
-- 			bloodId = math.random(10000, 99999)
-- 		end
-- 		return bloodId
-- 	else
-- 		local bloodId = math.random(10000, 99999)
-- 		return bloodId
-- 	end
-- end

-- function CreateFingerId()
--     if FingerDrops ~= nil then
-- 		local fingerId = math.random(10000, 99999)
-- 		while FingerDrops[caseId] ~= nil do
-- 			fingerId = math.random(10000, 99999)
-- 		end
-- 		return fingerId
-- 	else
-- 		local fingerId = math.random(10000, 99999)
-- 		return fingerId
-- 	end
-- end

-- function CreateCasingId()
--     if Casings ~= nil then
-- 		local caseId = math.random(10000, 99999)
-- 		while Casings[caseId] ~= nil do
-- 			caseId = math.random(10000, 99999)
-- 		end
-- 		return caseId
-- 	else
-- 		local caseId = math.random(10000, 99999)
-- 		return caseId
-- 	end
-- end

-- function CreateObjectId()
--     if Objects ~= nil then
-- 		local objectId = math.random(10000, 99999)
-- 		while Objects[caseId] ~= nil do
-- 			objectId = math.random(10000, 99999)
-- 		end
-- 		return objectId
-- 	else
-- 		local objectId = math.random(10000, 99999)
-- 		return objectId
-- 	end
-- end

-- function IsVehicleOwned(plate)
--     local val = false
-- 	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
-- 		if (result[1] ~= nil) then
-- 			val = true
-- 		else
-- 			val = false
-- 		end
-- 	end)
-- 	return val
-- end

-- QBCore.Functions.CreateCallback('armor:GetImpoundedVehicles', function(source, cb)
--     local vehicles = {}
--     exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE state = @state', {['@state'] = 2}, function(result)
--         if result[1] ~= nil then
--             vehicles = result
--         end
--         cb(vehicles)
--     end)
-- end)

-- QBCore.Functions.CreateCallback('armor:IsPlateFlagged', function(source, cb, plate)
--     local retval = false
--     if Plates ~= nil and Plates[plate] ~= nil then
--         if Plates[plate].isflagged then
--             retval = true
--         end
--     end
--     cb(retval)
-- end)

QBCore.Functions.CreateCallback('armor:GetCops', function(source, cb)
    local amount = 0
    
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
	cb(amount)
end)

--[[ QBCore.Commands.Add("setarmor", "Hire An Officer (armor Only)", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "armor" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("armor")
        end
    end
end) ]]

-- QBCore.Commands.Add("spikestrip", "Place Spike Strip (armor Only)", {}, false, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     if Player ~= nil then 
--         if (Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty) then
--             TriggerClientEvent('armor:client:SpawnSpikeStrip', source)
--         end
--     end
-- end)


--[[ QBCore.Commands.Add("firearmor", "Fire An Officer (armor Only)", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "armor" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("unemployed")
        end
    end
end) ]]

function IsHighCommand(citizenid)
    local retval = false
    for k, v in pairs(Config.ArmoryWhitelist) do
        if v == citizenid then
            retval = true
        end
    end
    return retval
end

-- QBCore.Commands.Add("pobject", "Place/Delete An Object (armor Only)", {{name="type", help="Type object you want or 'delete' to delete"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local type = args[1]:lower()
--     if Player.PlayerData.job.name == "armor" then
--         if type == "pion" then
--             TriggerClientEvent("armor:client:spawnCone", source)
--         elseif type == "barier" then
--             TriggerClientEvent("armor:client:spawnBarier", source)
--         elseif type == "schotten" then
--             TriggerClientEvent("armor:client:spawnSchotten", source)
--         elseif type == "tent" then
--             TriggerClientEvent("armor:client:spawnTent", source)
--         elseif type == "light" then
--             TriggerClientEvent("armor:client:spawnLight", source)
--         elseif type == "delete" then
--             TriggerClientEvent("armor:client:deleteObject", source)
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("cuff", "Cuff Player (armor Only)", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("armor:client:CuffPlayer", source)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("palert", "Make a armor alert", {{name="alert", help="The armor alert"}}, false, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
    
--     if (Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty) then
--         if args[1] ~= nil then
--             local msg = table.concat(args, " ")
--             TriggerClientEvent("chatMessage", -1, "armor ALERT", "error", msg)
--             TriggerEvent("qb-log:server:CreateLog", "palert", "armor alert", "blue", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Alert:** " ..msg, false)
--             TriggerClientEvent('armor:PlaySound', -1)
--         else
--             TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "You must enter message!")
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("escort", "Escort Player", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     TriggerClientEvent("armor:client:EscortPlayer", source)
-- end)

-- QBCore.Commands.Add("mdt", "Open MDT (armor Only)", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("armor:client:toggleDatabank", source)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("callsign", "Give Yourself A Callsign", {{name="name", help="Name of your callsign"}}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     Player.Functions.SetMetaData("callsign", table.concat(args, " "))
-- end)

-- QBCore.Commands.Add("clearcasings", "Clear Area of Casings (armor Only)", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("evidence:client:ClearCasingsInArea", source)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("jail", "Jail Player (armor Only)", {{name="id", help="Player ID"},{name="time", help="Time they have to be in jail"}}, true, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         local playerId = tonumber(args[1])
--         local time = tonumber(args[2])
--         if time > 0 then
--             TriggerClientEvent("armor:client:JailCommand", source, playerId, time)
--         else
--             TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Time must be higher then 0")
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("unjail", "Unjail Player (armor Only)", {{name="id", help="Player ID"}}, true, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         local playerId = tonumber(args[1])
--         TriggerClientEvent("prison:client:UnjailPerson", playerId)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("clearblood", "Clear The Area of Blood (armor Only)", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("evidence:client:ClearBlooddropsInArea", source)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("seizecash", "Seize Cash (armor Only)", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty then
--         TriggerClientEvent("armor:client:SeizeCash", source)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("sc", "Soft Cuff (armor Only)", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("armor:client:CuffPlayerSoft", source)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("cam", "View Security Camera (armor Only)", {{name="camid", help="Camera ID"}}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("armor:client:ActiveCamera", source, tonumber(args[1]))
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("flagplate", "Flag A Plate (armor Only)", {{name="plate", help="License"}, {name="reason", help="Reason of flagging the vehicle"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
    
--     if Player.PlayerData.job.name == "armor" then
--         local reason = {}
--         for i = 2, #args, 1 do
--             table.insert(reason, args[i])
--         end
--         Plates[args[1]:upper()] = {
--             isflagged = true,
--             reason = table.concat(reason, " ")
--         }
--         TriggerClientEvent('QBCore:Notify', source, "Vehicle ("..args[1]:upper()..") is flagged for: "..table.concat(reason, " "))
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("unflagplate", "Unflag A Plate (armor Only)", {{name="plate", help="License plate"}}, true, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         if Plates ~= nil and Plates[args[1]:upper()] ~= nil then
--             if Plates[args[1]:upper()].isflagged then
--                 Plates[args[1]:upper()].isflagged = false
--                 TriggerClientEvent('QBCore:Notify', source, "Vehicle ("..args[1]:upper()..") is unflagged")
--             else
--                 TriggerClientEvent('chatMessage', source, "REPORTING ROOM", "error", "Vehicle is not flagged!")
--             end
--         else
--             TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Vehicle is not flagged!")
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("plateinfo", "Run A Plate (armor Only)", {{name="plate", help="License plate"}}, true, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         if Plates ~= nil and Plates[args[1]:upper()] ~= nil then
--             if Plates[args[1]:upper()].isflagged then
--                 TriggerClientEvent('chatMessage', source, "REPORTING ROOM", "normal", "Vehicle ("..args[1]:upper()..") has been flagged for: "..Plates[args[1]:upper()].reason)
--             else
--                 TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Vehicle is not flagged!")
--             end
--         else
--             TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Vehicle is not flagged!")
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("depot", "Impound With Price (armor Only)", {{name="prijs", help="Price for how much the person has to pay (may be empty)"}}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("armor:client:ImpoundVehicle", source, false, tonumber(args[1]))
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("impound", "Impound A Vehicle (armor Only)", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("armor:client:ImpoundVehicle", source, true)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("paytow", "Pay Tow Driver (armor, EMS Only)", {{name="id", help="ID of the player"}}, true, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" or Player.PlayerData.job.name == "ambulance" then
--         local playerId = tonumber(args[1])
--         local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
--         if OtherPlayer ~= nil then
--             if OtherPlayer.PlayerData.job.name == "tow" then
--                 OtherPlayer.Functions.AddMoney("bank", 500, "armor-tow-paid")
--                 TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "SYSTEM", "warning", "You received $ 500 for your service!")
--                 TriggerClientEvent('QBCore:Notify', source, 'You paid a bergnet worker')
--             else
--                 TriggerClientEvent('QBCore:Notify', source, 'Person is not a bergnet worker', "error")
--             end
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("paylawyer", "Pay Lawyer (armor, Judge Only)", {{name="id", help="ID of the player"}}, true, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" or Player.PlayerData.job.name == "judge" then
--         local playerId = tonumber(args[1])
--         local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
--         if OtherPlayer ~= nil then
--             if OtherPlayer.PlayerData.job.name == "lawyer" then
--                 OtherPlayer.Functions.AddMoney("bank", 500, "armor-lawyer-paid")
--                 TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "SYSTEM", "warning", "You received $ 500 for your pro bono case!")
--                 TriggerClientEvent('QBCore:Notify', source, 'You paid a lawyer')
--             else
--                 TriggerClientEvent('QBCore:Notify', source, 'Person is not a lawyer', "error")
--             end
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("radar", "Enable armor Radar (armor Only)", {}, false, function(source, args)
-- 	local Player = QBCore.Functions.GetPlayer(source)
--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("wk:toggleRadar", source)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Functions.CreateUseableItem("handcuffs", function(source, item)
--     local Player = QBCore.Functions.GetPlayer(source)
-- 	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
--         TriggerClientEvent("armor:client:CuffPlayerSoft", source)
--     end
-- end)

-- QBCore.Commands.Add("911", "Send a report to emergency services", {{name="message", help="Message you want to send"}}, true, function(source, args)
--     local message = table.concat(args, " ")
--     local Player = QBCore.Functions.GetPlayer(source)

--     if Player.Functions.GetItemByName("phone") ~= nil then
--         TriggerClientEvent("armor:client:SendEmergencyMessage", source, message)
--         TriggerEvent("qb-log:server:CreateLog", "911", "911 alert", "blue", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Alert:** " ..message, false)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'You dont have a phone', 'error')
--     end
-- end)

-- QBCore.Commands.Add("911a", "Send an anonymous report to emergency services (gives no location)", {{name="message", help="Message you want to send"}}, true, function(source, args)
--     local message = table.concat(args, " ")
--     local Player = QBCore.Functions.GetPlayer(source)

--     if Player.Functions.GetItemByName("phone") ~= nil then
--         TriggerClientEvent("armor:client:CallAnim", source)
--         TriggerClientEvent('armor:client:Send112AMessage', -1, message)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'You dont have a phone', 'error')
--     end
-- end)

-- QBCore.Commands.Add("911r", "Send a message back to a alert", {{name="id", help="ID of the alert"}, {name="bericht", help="Message you want to send"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     table.remove(args, 1)
--     local message = table.concat(args, " ")
--     local Prefix = "armor"
--     if (Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") then
--         Prefix = "AMBULANCE"
--     end
--     if OtherPlayer ~= nil then 
--         TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "("..Prefix..") " ..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname, "error", message)
--         TriggerClientEvent("armor:client:EmergencySound", OtherPlayer.PlayerData.source)
--         TriggerClientEvent("armor:client:CallAnim", source)
--     end
-- end)

-- QBCore.Commands.Add("anklet", "Attach Tracking Anklet (armor Only)", {}, false, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)

--     if Player.PlayerData.job.name == "armor" then
--         TriggerClientEvent("armor:client:CheckDistance", source)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("removeanklet", "Remove Tracking Anklet (armor Only)", {{"bsn", "BSN of person"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
    
--     if Player.PlayerData.job.name == "armor" then
--         if args[1] ~= nil then
--             local citizenid = args[1]
--             local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)

--             if Target ~= nil then
--                 if Target.PlayerData.metadata["tracker"] then
--                     TriggerClientEvent("armor:client:SendTrackerLocation", Target.PlayerData.source, source)
--                 else
--                     TriggerClientEvent('QBCore:Notify', source, 'This person does not have an anklet', 'error')
--                 end
--             end
--         end
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'For Emergency Services Only', 'error')
--     end
-- end)

-- QBCore.Commands.Add("ebutton", "Respond To A Call (armor, EMS, Mechanic Only)", {}, false, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     if ((Player.PlayerData.job.name == "armor" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
--         TriggerClientEvent("armor:client:SendarmorEmergencyAlert", source)
--     end
-- end)

-- QBCore.Commands.Add("takedrivinglicense", "Seize Drivers License (armor Only)", {}, false, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     if ((Player.PlayerData.job.name == "armor") and Player.PlayerData.job.onduty) then
--         TriggerClientEvent("armor:client:SeizeDriverLicense", source)
--     end
-- end)

-- QBCore.Commands.Add("takedna", "Take a DNA sanple from a person (empty evidence bag needed) (armor Only)", {{"id", "ID of the person"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     if ((Player.PlayerData.job.name == "armor") and Player.PlayerData.job.onduty) and OtherPlayer ~= nil then
--         if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
--             local info = {
--                 label = "DNA Sample",
--                 type = "dna",
--                 dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid),
--             }
--             if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
--                 TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["filled_evidence_bag"], "add")
--             end
--         else
--             TriggerClientEvent('QBCore:Notify', source, "You must have an empty evidence bag with you", "error")
--         end
--     end
-- end)

-- QBCore.Functions.CreateUseableItem("moneybag", function(source, item)
--     local Player = QBCore.Functions.GetPlayer(source)
--     if Player.Functions.GetItemBySlot(item.slot) ~= nil then
--         if item.info ~= nil and item.info ~= "" then
--             if Player.PlayerData.job.name ~= "armor" then
--                 if Player.Functions.RemoveItem("moneybag", 1, item.slot) then
--                     Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
--                 end
--             end
--         end
--     end
-- end)

function GetCurrentCops()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "armor" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    return amount
end

-- QBCore.Functions.CreateCallback('armor:server:IsarmorForcePresent', function(source, cb)
--     local retval = false
--     for k, v in pairs(QBCore.Functions.GetPlayers()) do
--         local Player = QBCore.Functions.GetPlayer(v)
--         if Player ~= nil then 
--             for _, citizenid in pairs(Config.ArmoryWhitelist) do
--                 if citizenid == Player.PlayerData.citizenid then
--                     retval = true
--                     break
--                 end
--             end
--         end
--     end
--     cb(retval)
-- end)

-- function DnaHash(s)
--     local h = string.gsub(s, ".", function(c)
-- 		return string.format("%02x", string.byte(c))
-- 	end)
--     return h
-- end

-- RegisterServerEvent('armor:server:SyncSpikes')
-- AddEventHandler('armor:server:SyncSpikes', function(table)
--     TriggerClientEvent('armor:client:SyncSpikes', -1, table)
-- end)
QBCore.Commands.Add("licencia", "Poner factura (armor Only)", {{name="id", help="Player ID"},{name="price", help="Cantidad de dinero factura"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "armor" then
        local playerId = tonumber(args[1])
        local price = tonumber(args[2])
        if price > 0 then
            TriggerClientEvent("armor:client:BillCommand", source, playerId, price)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Time must be higher then 0")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'For armor Only', 'error')
    end
end)