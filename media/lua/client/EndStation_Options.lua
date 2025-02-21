EndStation = EndStation or {}

EndStation.currentTriggerMode = SandboxVars.EndStation.TriggerModes or 4

EndStation.TriggerEvents = {
    ['1'] = { event = Events.EveryOneMinute },
    ['2'] = { event = Events.EveryTenMinutes },
    ['3'] = { event = Events.EveryTenMinutes },
    ['4'] = { event = Events.EveryHours },
    ['5'] = { event = Events.EveryDays }
}

EndStation.currentEvent = nil

function EndStation.preDeviceHandler()
    local mode = tostring(SandboxVars.EndStation.TriggerModes)
    if mode == "3" and not EndStation.IsThirtyMinutesPast() then
        return
    end
    EndStation.deviceHandler()
end

function EndStation.updateTriggers()
    if EndStation.currentEvent then
        EndStation.currentEvent.event.Remove(EndStation.preDeviceHandler)
    end

    local mode = tostring(SandboxVars.EndStation.TriggerModes)
    local trigger = EndStation.TriggerEvents[mode]

    if trigger then
        trigger.event.Add(EndStation.preDeviceHandler)
        EndStation.currentEvent = trigger
    else
        EndStation.currentEvent = nil
    end
end
function EndStation.saveSandbox()
    if EndStation.currentEvent then
        EndStation.currentEvent.event.Remove(EndStation.preDeviceHandler)
    end
    local sOpt = getSandboxOptions()
    sOpt:getOptionByName("EndStation.RadioDetectDistance"):setValue(SandboxVars.EndStation.RadioDetectDistance)
    sOpt:getOptionByName("EndStation.Sound"):setValue(SandboxVars.EndStation.Sound)
    sOpt:getOptionByName("EndStation.ShouldShowText"):setValue(SandboxVars.EndStation.ShouldShowText)
    sOpt:getOptionByName("EndStation.TriggerModes"):setValue(SandboxVars.EndStation.TriggerModes)


    sOpt:toLua()
    sOpt:sendToServer()
    print("EndStation: SandboxVars Synced")

    EndStation.updateTriggers()
end

function EndStation.isSandboxChanged()
    local newMode = SandboxVars.EndStation.TriggerModes
    if newMode ~= EndStation.currentTriggerMode then
        EndStation.currentTriggerMode = newMode
        getPlayer():addLineChatElement("EndStation: sandbox updated")
        return true
    end
end

function EndStation.IsThirtyMinutesPast()
    return getGameTime():getMinutes() == 30
end

function EndStation.deviceHandler()
    if EndStation.isSandboxChanged() then
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

EndStation.updateTriggers()
