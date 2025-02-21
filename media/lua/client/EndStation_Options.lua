
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

local mode = SandboxVars.EndStation.TriggerModes or 4
EndStation.currentTriggerMode = mode
EndStation.shouldSync = false

EndStation.TriggerEvents = {
    ['1'] = { event = Events.EveryOneMinute, condition = function() return SandboxVars.EndStation.TriggerModes == 1 end },
    ['2'] = { event = Events.EveryTenMinutes, condition = function() return SandboxVars.EndStation.TriggerModes == 2 end },
    ['3'] = { event = Events.EveryTenMinutes, condition = function() return SandboxVars.EndStation.TriggerModes == 3 and EndStation.IsThirtyMinutesPast() end },
    ['4'] = { event = Events.EveryHours, condition = function() return SandboxVars.EndStation.TriggerModes == 4 end },
    ['5'] = { event = Events.EveryDays, condition = function() return SandboxVars.EndStation.TriggerModes == 5 end }
}

EndStation.currentEvent = nil

function EndStation.preDeviceHandler()
    if EndStation.TriggerEvents[tostring(SandboxVars.EndStation.TriggerModes)] and EndStation.TriggerEvents[tostring(SandboxVars.EndStation.TriggerModes)].condition() then
        EndStation.deviceHandler()
    end
end

function EndStation.retrigger(mode)
    if EndStation.currentEvent then
        EndStation.currentEvent.event.Remove(EndStation.preDeviceHandler)
    end

    local trigger = EndStation.TriggerEvents[tostring(mode)]
    if trigger then
        trigger.event.Add(EndStation.preDeviceHandler)
        EndStation.currentEvent = trigger
    else
        EndStation.currentEvent = nil
    end
end

function EndStation.saveSandbox()
    local sOpt = getSandboxOptions()
    local options = {
        RadioDetectDistance = SandboxVars.EndStation.RadioDetectDistance,
        Sound = SandboxVars.EndStation.Sound,
        ShouldShowText = SandboxVars.EndStation.ShouldShowText,
        TriggerModes = SandboxVars.EndStation.TriggerModes
    }

    for key, value in pairs(options) do
        sOpt:getOptionByName("EndStation." .. key):setValue(tostring(value))
    end

    sOpt:toLua()
    sOpt:sendToServer()
    print("EndStation SandboxVars Synced")

    EndStation.shouldSync = false
    EndStation.retrigger(SandboxVars.EndStation.TriggerModes)
end

function EndStation.isSandboxChanged()
    local newMode = SandboxVars.EndStation.TriggerModes
    local curMode = EndStation.currentTriggerMode

    if EndStation.shouldSync then
        EndStation.saveSandbox()
        EndStation.shouldSync = false
    end

    if newMode ~= curMode then
        EndStation.shouldSync = true
        EndStation.currentTriggerMode = newMode
        getPlayer():addLineChatElement("EndStation: sandbox updated")
        return true
    end
end

function EndStation.is10MinTrigger()
    local mode = SandboxVars.EndStation.TriggerModes or 4
    local TriggerModesTable = { ['1'] = false, ['2'] = true, ['3'] = true, ['4'] = false, ['5'] = false }
    return TriggerModesTable[tostring(mode)]
end

function EndStation.IsThirtyMinutesPast()
    return getGameTime():getMinutes() == 30
end

function EndStation.deviceHandler()
    if EndStation.isSandboxChanged() then
        EndStation.shouldSync = true
        EndStation.saveSandbox()
    end

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

local hook = ISServerSandboxOptionsUI.onButtonApply
function ISServerSandboxOptionsUI:onButtonApply()
    hook(self)
    EndStation.saveSandbox()
    if isAdmin() or EndStation.dbg then
        print("EndStation: sandbox updated")
        getPlayer():addLineChatElement("EndStation: sandbox updated")
    end
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

