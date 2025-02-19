

EndStation = EndStation or {}
EndStation.dbg = false

function EndStation.getEndStationRadioInRange()
    local rad =  SandboxVars.EndStation.RadioDetectDistance or 15
    local pl = getPlayer()
    local cell = pl:getCell()
    local x, y, z = pl:getX(), pl:getY(), pl:getZ()
    for xDelta = -rad, rad do
        for yDelta = -rad, rad do
            local sq = cell:getOrCreateGridSquare(x + xDelta, y + yDelta, z)
            for i=0, sq:getObjects():size()-1 do
                local obj = sq:getObjects():get(i)
                if obj and instanceof(obj, "IsoRadio") then
                    if EndStation.isValid(obj) then
                        local radio = obj:getDeviceData()
                        if radio and EndStation.isWithinRange(x, y, z, obj) then
                            local bool = SandboxVars.EndStation.ShouldShowText or true
                            if bool or EndStation.dbg  then
                                local msg = "EndStation: "..tostring(radio:getDeviceName()).." "..tostring(radio:getChannel())
                                print(tostring(msg))
                                --pl:Say(msg, 1.0, 1.0, 1.0, UIFont.Dialogue, 30, "radio")
                                pl:addLineChatElement(tostring(msg))
                            end

                            return obj
                        end
                    end
                end
            end
        end
    end
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
        --[freq] = "sound file"
        --[100000] = "EndStation_Broadcast",
        [120000] = "EndStation_Broadcast1",
    }
    return tab[key]
end



function EndStation.isValid(obj)
    if not (obj or instanceof(obj, "IsoRadio")) then return end
    local radio = obj:getDeviceData()
    if radio then
        return radio:getIsTurnedOn()
    end
    return false
end

function EndStation.getSound()
    return SandboxVars.EndStation.Sound or "EndStation_Broadcast1"
end

function EndStation.deviceHandler()
    local pl = getPlayer()
    local obj = EndStation.getEndStationRadioInRange()
    if obj then
        local sfx = EndStation.channelData(obj)
        if sfx then
            --pl:playSoundLocal(tostring(sfx))
           -- getSoundManager():playUISound(tostring(sfx))
            getSoundManager():playUISound(sfx)

        end
    end
end
Events.EveryHours.Remove(EndStation.deviceHandler)
Events.EveryHours.Add(EndStation.deviceHandler)