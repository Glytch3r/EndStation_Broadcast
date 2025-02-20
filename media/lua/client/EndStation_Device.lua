
--[[██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
   ░▒▓█████▓▒░     ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓███████▓▒░   ░▒▓██████▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░  ░▒▓███████▓▒░    ░▒▓███████▓▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░  ▒▓░    ░▒▓█▓▒░   ░▒▓█▒░  ░▒▓█▒░
  ░▒▓█▓▒░          ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█▓▒░ ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▒░  ░▒▓█▒░
  ░▒▓█▓▒▒▓███▓▒░   ░▒▓█▓▒░         ░▒▓██████▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█████████▓▒░     ░▒▓███▓▒░     ░▒▓███████▓▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█▓▒░ ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░  ░▒▓▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░  ▒▓░    ░▒▓█▓▒░   ░▒▓█▓▒░  ░▒█▒░
   ░▒▓██████▓▒░    ░▒▓████████▓▒░    ░▒▓█▓▒░         ░▒▓█▓▒░      ░▒▓██████▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░  ░▒▓███████▓▒░    ░▒▓█▓▒░  ░▒█▒░
|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
|                        				 Custom  PZ  Mod  Developer  for  Hire													  |
|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
|                       	Portfolio:  https://steamcommunity.com/id/glytch3r/myworkshopfiles/							          |
|                       		                                    														 	  |
|                       	Discord:    Glytch3r#1337 / glytch3r															      |
|                       		                                    														 	  |
|                       	Support:    https://ko-fi.com/glytch3r														    	  |
|_______________________________________________________________________________________________________________________________-]]

EndStation = EndStation or {}
EndStation.dbg = false

function EndStation.getCar()
    local pl = getPlayer()
    return pl:getVehicle() or pl:getNearVehicle() or pl:getUseableVehicle()
end

function EndStation.getPlayerRadio(pl)
    pl = pl or getPlayer()
    local inv = pl:getInventory()
    for i = 0, inv:getItems():size() - 1 do
        local item = inv:getItems():get(i)
        if item and EndStation.isValid(item) then
            return item
        end
    end
    return nil
end


function EndStation.getTurnedOnVehicleRadio()
    local car = EndStation.getCar()
    if car then
        for partIndex=1, car:getPartCount() do
            local part = car:getPartByIndex(partIndex-1)
            local radio = part:getDeviceData()
            if radio and radio:getIsTurnedOn() then
                return part
            end
        end
    end
    return nil
end

--[[

function EndStation.getNearbyPlayerRadio(pl)
    pl = pl or getPlayer()
    local players = getOnlinePlayers()
    if not players then return nil end

    for i = 0, players:size() - 1 do
        local otherPl = players:get(i)
        if otherPl ~= pl then
            local radio = EndStation.getTurnedOnInventoryRadio(otherPl) or EndStation.getTurnedOnVehicleRadio(otherPl)
            if radio then
                return radio
            end
        end
    end
    return nil
end ]]

function EndStation.getEndStationRadioInRange(pl)
    pl = pl or getPlayer()
    local rad = SandboxVars.EndStation.RadioDetectDistance or 15
    local cell = pl:getCell()
    local x, y, z = pl:getX(), pl:getY(), pl:getZ()

    for xDelta = -rad, rad do
        for yDelta = -rad, rad do
            local sq = cell:getOrCreateGridSquare(x + xDelta, y + yDelta, z)
            for i = 0, sq:getObjects():size() - 1 do
                local obj = sq:getObjects():get(i)
                if obj and EndStation.isValid(obj) then
                    local radio = obj:getDeviceData()
                    if radio and EndStation.isWithinRange(x, y, z, obj) then
                        return obj
                    end
                end
            end
        end
    end
    return nil
end

function EndStation.isValid(obj)
    if not obj then return false end
    if instanceof(obj, "IsoRadio") or instanceof(obj, "Radio") or instanceof(obj, "IsoWaveSignal") then
        local radio = obj:getDeviceData()
        return radio and radio:getIsTurnedOn()
    end
    return false
end

function EndStation.isWithinRange(px, py, pz, obj)
    local dx, dy, dz = obj:getX(), obj:getY(), obj:getZ()
    local range = obj:getDeviceData():getTransmitRange()
    return (px - dx)^2 + (py - dy)^2 <= range^2 and pz == dz
end

function EndStation.channelData(obj)
    local radio = obj:getDeviceData()
    if not radio then return nil end
    local key = radio:getChannel()
    local tab = {
        [100000] = "EndStation_Broadcast1", --FREQ*
        --[120000] = "EndStation_Broadcast2",
    }
    return tab[key]
end

function EndStation.getSound()
    return SandboxVars.EndStation.Sound or "EndStation_Broadcast1"
end

function EndStation.deviceHandler()
    local pl = getPlayer()
    local part = EndStation.getTurnedOnVehicleRadio()
    local item = EndStation.getPlayerRadio()
    local obj = EndStation.getEndStationRadioInRange() or item or part

    if obj then
        if SandboxVars.EndStation.ShouldShowText or EndStation.dbg then
            local msg = "EndStation: " .. tostring(obj:getDeviceData():getDeviceName()) .. " " .. tostring(obj:getDeviceData():getChannel())
            print(msg)
            pl:addLineChatElement(msg)
        end

        local sfx = EndStation.channelData(obj)
        if sfx then
            getSoundManager():playUISound(sfx)
        end
    end
end

local isTriggerPerMin = SandboxVars.EndStation.TriggerPerMin or false
if isTriggerPerMin then
    Events.EveryOneMinute.Add(EndStation.deviceHandler)
else
    Events.EveryHours.Add(EndStation.deviceHandler)
end
--[[_____________________________________________________________________________________________________________________________
   ░▒▓██████▓▒░    ░▒▓████████▓▒░    ░▒▓█▓▒░         ░▒▓█▓▒░      ░▒▓██████▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░  ░▒▓███████▓▒░    ░▒▓█▓▒░  ░▒█▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░  ▒▓░    ░▒▓█▓▒░   ░▒▓█▓▒░  ░▒█▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█▓▒░ ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░  ░▒▓▒░
  ░▒▓█▓▒▒▓███▓▒░   ░▒▓█▓▒░         ░▒▓██████▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█████████▓▒░     ░▒▓███▓▒░     ░▒▓███████▓▒░
  ░▒▓█▓▒░          ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█▓▒░ ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▒░  ░▒▓█▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░  ▒▓░    ░▒▓█▓▒░   ░▒▓█▒░  ░▒▓█▒░
   ░▒▓█████▓▒░     ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓███████▓▒░   ░▒▓██████▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░  ░▒▓███████▓▒░    ░▒▓███████▓▒░
█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████--]]

