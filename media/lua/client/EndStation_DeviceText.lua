

local function OnDeviceText(guid, codes, x, y, z, text, device)
    if guid == "MODS-DerHauge" and codes == "MODS_LOOP" then
        if (getCore():getDebug() and isAdmin()) then
            print("[EndStation] Broadcast Message: " .. text)
        end
        local player = getPlayer()
        if player and player:getSquare():DistTo(x, y) < 30 then
            getSoundManager():PlayWorldSound("EndStationRadio", player:getSquare(), 0, 20, 1, false)
        end
    end
end

Events.OnDeviceText.Add(OnDeviceText)
