
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

EndStation.currentTriggerMode = SandboxVars.EndStation.TriggerModes or 4

function EndStation.getSound()
    return SandboxVars.EndStation.Sound or "EndStation_Broadcast1"
end

-----------------------            ---------------------------
function EndStation.saveSandbox()
    local sOpt = getSandboxOptions()
    local opt1 = SandboxVars.EndStation.RadioDetectDistance
    local opt2 = SandboxVars.EndStation.Sound
    local opt3 = SandboxVars.EndStation.ShouldShowText
    local opt4 = SandboxVars.EndStation.TriggerModes

    sOpt:getOptionByName("EndStation.RadioDetectDistance"):setValue(tostring(opt1))
    sOpt:getOptionByName("EndStation.Sound"):setValue(tostring(opt2))
    sOpt:getOptionByName("EndStation.ShouldShowText"):setValue(tostring(opt3))
    sOpt:getOptionByName("EndStation.TriggerModes"):setValue(tostring(opt4))
    sOpt:toLua()
    sOpt:sendToServer()
    print("EndStation SandboxVars Synced")
end
-----------------------            ---------------------------

function EndStation.triggerHandler()
    if EndStation.isSandboxChanged() then
        EndStation.saveSandbox()
        EndStation.retrigger(tostring(SandboxVars.EndStation.TriggerModes))
    end
end
Events.EveryOneMinute.Add(EndStation.triggerHandler)



function EndStation.isSandboxChanged()
    local newMode = tostring(SandboxVars.EndStation.TriggerModes)
    local curMode = tostring(EndStation.currentTriggerMode)
    if newMode ~= curMode then
        EndStation.currentTriggerMode = newMode
        getPlayer():addLineChatElement('EndStation: sandbox updated')
        return true
    end
end
function EndStation.retrigger(mode)
      EndStation.clearTriggers()
    if mode == "1" then
        Events.EveryOneMinute.Add(EndStation.deviceHandler)
    elseif EndStation.is10MinTrigger(mode) then
        Events.EveryTenMinutes.Add(EndStation.deviceHandler)
    elseif mode == "4" then
        Events.EveryHours.Add(EndStation.deviceHandler)
    elseif mode == "5" then
        Events.EveryDays.Add(EndStation.deviceHandler)
    end
end

function EndStation.clearTriggers()
    if getCore():getDebug() or EndStation.dbg then
        print("EndStation: Triggers Cleared")
	end
    Events.EveryOneMinute.Remove(EndStation.deviceHandler)
    Events.EveryTenMinutes.Remove(EndStation.deviceHandler)
    --Events.EveryTenMinutes.Remove(EndStation.deviceHandler)
    Events.EveryHours.Remove(EndStation.deviceHandler)
    Events.EveryDays.Remove(EndStation.deviceHandler)
end

function EndStation.is10MinTrigger(mode)
    local TriggerModesTable = {
        ['1'] = false,

        ['2'] = true,
        ['3'] = true,

        ['4'] = false,
        ['5'] = false,
    }

    return TriggerModesTable[mode]
end


function EndStation.IsThirtyMinutesPast()
    return getGameTime():getMinutes() == 30
end


function EndStation.deviceHandler()
    local bool = true
    local mode = tostring(SandboxVars.EndStation.TriggerModes)
    if EndStation.is10MinTrigger(mode) and mode  == "3" then
        if not EndStation.IsThirtyMinutesPast() then
            bool = false
        end
    end
    if bool then
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
end

-----------------------            ---------------------------
local hook = ISServerSandboxOptionsUI.onButtonApply
function ISServerSandboxOptionsUI:onButtonApply()
    EndStation.saveSandbox()
    EndStation.retrigger(tostring(SandboxVars.EndStation.TriggerModes)) -- Pass the mode
   	if isAdmin() or  EndStation.dbg then
        print('EndStation: sandbox updated')
	end
    hook(self)
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

