
EndStation={}
function EndStation.broadcast(guid, codes, x, y, z, text, device)
    print(guid)
    print(text)
    if guid == "MODS-DerHauge" and codes == "MODS_LOOP" then
        if (getCore():getDebug() and isAdmin()) then
            print("[EndStation] Broadcast Message: " .. text)
        end
        local player = getPlayer()
        if player and player:getSquare():DistTo(x, y) < 30 then
            getSoundManager():PlayWorldSound("EndStation_Broadcast1", player:getSquare(), 0, 20, 1, false)
        end
    end
end

Events.OnDeviceText.Add(EndStation.broadcast)
