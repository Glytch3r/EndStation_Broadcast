

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
                if instanceof(obj, "IsoRadio") then
                    if EndStation.isValid(obj) then
                        local radio = obj:getDeviceData()
                        if radio then

                            local bool = SandboxVars.EndStation.ShouldShowText or true
                            if bool or  EndStation.dbg  then
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


function EndStation.isValid(obj)
    if not (obj or instanceof(obj, "IsoRadio")) then return end
    local radio = obj:getDeviceData()
    if radio then
        local pl = getPlayer()
        if EndStation.isWithinRange(round(pl:getX()),  round(pl:getY()),  pl:getZ(), obj) then
            return radio:getIsTurnedOn() and radio:getChannel() == 100000
        end
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
        local sfx = EndStation.getSound()
        if not obj:getEmitter():isPlaying(sfx) then
            obj:getEmitter():playSound(tostring(sfx))
        end
    end
end
Events.EveryTenMinutes.Remove(EndStation.deviceHandler)
Events.EveryTenMinutes.Add(EndStation.deviceHandler)

