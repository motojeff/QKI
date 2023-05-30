-- Quicky Kiss It.lua V1 By MotoJeff. A clunky little lua GUI that allows on the fly modification to kissassist variables and stuff.-- 
--You Must RUN Kissassist for any of this to function. The variables and what they do match kissassist, if you are not sure please refer to the kissassist wiki --
--Set up your normal kissassist ini file for your toon, run kissassist in game, load QKI.lua, check your boxes. --
--V1 does not import any settings from the INI at start up it will default to unchecked in the lua, but will do what ever is saved in your ini until you check a box in the gui.--
local mq = require('mq')
require 'ImGui'

local openGUI = true
local shouldDrawGUI = true
local stuffLabels = {
    "Chase", "Return to Camp", "Burn",
    "Single Mez", "AE Mez", "Use AE", "Melee", "Med Combat",
    "Buffs", "Rebuff", "Auto Fire", "Auto Rez",
    "Use Pet", "Pet Toys", "Scatter", "Heals"
}

local moreStuffLabels = {
    "Campfire", "Group Escape", "Twist", "Face Mob",
    "Debuff All", "Xtar Heal", "Cure", "Pet Shrink",
    "Pull Twist", "Chain Pull", "Auto Hide", "Aggro"
}


local checkboxStates = {
    SingleMez = false,
    Chase = false,
    ReturntoCamp = false,
    Burn = false,
    AEMez = false,
    UseAE = false,
    Melee = false,
    MedCombat = false,
    Buffs = false,
    Rebuff = false,
    AutoFire = false,
    AutoRez = false,
    UsePet = false,
    PetToys = false,
    Scatter = false,
    Heals = false,
    Campfire = false,
    GroupEscape = false,
    Twist = false,
    FaceMob = false,
    DebuffAll = false,
    XtarHeal = false,
    Cure = false,
    PetShrink = false,
    PullTwist = false,
    ChainPull = false,
    AutoHide = false,
    Aggro = false
}

local function DrawMainWindow()
    if not openGUI then return end
    openGUI, shouldDrawGUI = ImGui.Begin('Quicky Kiss It', openGUI)
    if shouldDrawGUI then

        ImGui.Text("Make sure Kissassist Is Running!")

        for _, label in ipairs(stuffLabels) do
            local isChecked = checkboxStates[label]
            local newValue, valueChanged = ImGui.Checkbox(label, isChecked)
            if valueChanged then
                checkboxStates[label] = newValue
                if label == "Single Mez" then
                    ToggleSingleMezAction(newValue)
                elseif label == "Chase" then
                    ToggleChaseAction(newValue)
                elseif label == "Return to Camp" then
                    ToggleReturntoCampAction(newValue)
                elseif label == "Burn" then
                    ToggleBurnAction(newValue)
                elseif label == "AE Mez" then
                    ToggleAEMezAction(newValue)
                elseif label == "Use AE" then
                    ToggleUseAEAction(newValue)
                elseif label == "Melee" then
                    ToggleMeleeAction(newValue)
                elseif label == "Med Combat" then
                    ToggleMedCombatAction(newValue)
                elseif label == "Buffs" then
                    ToggleBuffsAction(newValue)
                elseif label == "Rebuff" then
                    ToggleRebuffAction(newValue)
                elseif label == "Auto Fire" then
                    ToggleAutoFireAction(newValue)
                elseif label == "Auto Rez" then
                    ToggleAutoRezAction(newValue)
                elseif label == "Use Pet" then
                    ToggleUsePetAction(newValue)
                elseif label == "Pet Toys" then
                    TogglePetToysAction(newValue)
                elseif label == "Scatter" then
                    ToggleScatterAction(newValue)
                elseif label == "Heals" then
                    ToggleHealsAction(newValue)
                end
            end
            ImGui.SameLine()
        end

        ImGui.NewLine()

        for _, label in ipairs(moreStuffLabels) do
            local isChecked = checkboxStates[label]
            local newValue, valueChanged = ImGui.Checkbox(label, isChecked)
            if valueChanged then
                checkboxStates[label] = newValue
                if label == "Campfire" then
                    ToggleCampfireAction(newValue)
                elseif label == "Group Escape" then
                    ToggleGroupEscapeAction(newValue)
                elseif label == "Twist" then
                    ToggleTwistAction(newValue)
                elseif label == "Face Mob" then
                    ToggleFaceMobAction(newValue)
                elseif label == "Debuff All" then
                    ToggleDebuffAllAction(newValue)
                elseif label == "Xtar Heal" then
                    ToggleXtarHealAction(newValue)
                elseif label == "Cure" then
                    ToggleCureAction(newValue)
                elseif label == "Pet Shrink" then
                    TogglePetShrinkAction(newValue)
                elseif label == "Pull Twist" then
                    TogglePullTwistAction(newValue)
                elseif label == "Chain Pull" then
                    ToggleChainPullAction(newValue)
                elseif label == "Auto Hide" then
                    ToggleAutoHideAction(newValue)
                elseif label == "Aggro" then
                    ToggleAggroAction(newValue)
                end
            end
            ImGui.SameLine()
        end

        ImGui.NewLine()

        if isPaused then
            if ImGui.Button("Resume") then
                mq.cmd('/mqp off')
                isPaused = false
            end
        else
            if ImGui.Button("Pause") then
                mq.cmd('/mqp on')
                isPaused = true
            end
        end

        ImGui.SameLine()

        if ImGui.Button("Restart Kiss") then
            mq.cmd('/mac kissassist')
        end

        ImGui.SameLine()

        if ImGui.Button("Force Rebuff") then
            mq.cmd('/buffgroup')
        end

        ImGui.SameLine()

        if ImGui.Button("Start Kiss as Puller") then
            mq.cmd('/mac kissassist puller')
        end

        ImGui.SameLine()

        if ImGui.Button("STAHP!!!") then
            mq.cmd('/squelch /multiline ; /end; /afollow off; /stick off; /moveto off; /nav stop; /play off; /mqp on; /attack off; /twist off;')
        end

        ImGui.SameLine()

        if ImGui.Button("Ignore Target") then
            mq.cmd('/addignore "${Target.CleanName}"')
        end
    end
    ImGui.End()
end

function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function ToggleSingleMezAction(isChecked)
    if isChecked then
        mq.cmd('/mezon 1')
    else
        mq.cmd('/mezon 0')
    end
end

function ToggleChaseAction(isChecked)
    if isChecked then
        mq.cmd('/chase on')
    else
        mq.cmd('/chase off')
    end
end

function ToggleReturntoCampAction(isChecked)
    if isChecked then
        mq.cmd('/camphere on')
    else
        mq.cmd('/camphere off')
    end
end

function ToggleBurnAction(isChecked)
    if isChecked then
        mq.cmd('/burn on')
    else
        mq.cmd('/burn off')
    end
end

function ToggleAEMezAction(isChecked)
    if isChecked then
        mq.cmd('/mezon 3')
    else
        mq.cmd('/mezon 0')
    end
end

function ToggleUseAEAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable aeon 1')
    else
        mq.cmd('/togglevariable aeon 0')
    end
end

function ToggleMeleeAction(isChecked)
    if isChecked then
        mq.cmd('/meleeon 1')
    else
        mq.cmd('/meleeon 2')
    end
end

function ToggleMedCombatAction(isChecked)
    if isChecked then
        mq.cmd('/medcombat 1')
    else
        mq.cmd('/medcombat 2')
    end
end

function ToggleBuffsAction(isChecked)
    if isChecked then
        mq.cmd('/buffson 1')
    else
        mq.cmd('/buffson 0')
    end
end

function ToggleRebuffAction(isChecked)
    if isChecked then
        mq.cmd('/rebuffon 1')
    else
        mq.cmd('/rebuffon 0')
    end
end

function ToggleAutoFireAction(isChecked)
    if isChecked then
        mq.cmd('/autofireon 1')
    else
        mq.cmd('/autofireon 0')
    end
end

function ToggleAutoRezAction(isChecked)
    if isChecked then
        mq.cmd('/autorezon 1')
    else
        mq.cmd('/autorezon 0')
    end
end

function ToggleUsePetAction(isChecked)
    if isChecked then
        mq.cmd('/peton 1')
    else
        mq.cmd('/peton 2')
    end
end

function TogglePetToysAction(isChecked)
    if isChecked then
        mq.cmd('/PetToysOn 1')
    else
        mq.cmd('/PetToysOn 0')
    end
end

function ToggleScatterAction(isChecked)
    if isChecked then
        mq.cmd('/scatteron 1')
    else
        mq.cmd('/scatteron 0')
    end
end

function ToggleHealsAction(isChecked)
    if isChecked then
        mq.cmd('/Healson 1')
    else
        mq.cmd('/Healson 0')
    end
end

function ToggleCampfireAction(isChecked)
    if isChecked then
        mq.cmd('/campfire on')
    else
        mq.cmd('/campfire off')
    end
end

function ToggleGroupEscapeAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable groupescapeon 1')
    else
        mq.cmd('/togglevariable groupescapeon 0')
    end
end

function ToggleTwistAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable twiston 1')
    else
        mq.cmd('/togglevariable twiston 0')
    end
end

function ToggleFaceMobAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable facemobon 1')
    else
        mq.cmd('/togglevariable facemobon 0')
    end
end

function ToggleDebuffAllAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable debuffallon 1')
    else
        mq.cmd('/togglevariable debuffallon 0')
    end
end

function ToggleXtarHealAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable xtarheal 1')
    else
        mq.cmd('/togglevariable xtarheal 0')
    end
end

function ToggleCureAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable cureson 1')
    else
        mq.cmd('/togglevariable cureson 0')
    end
end

function TogglePetShrinkAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable petshrinkon 1')
    else
        mq.cmd('/togglevariable petshrinkon 0')
    end
end

function TogglePullTwistAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable pulltwiston 1')
    else
        mq.cmd('/togglevariable pulltwiston 0')
    end
end

function ToggleChainPullAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable chainpull 1')
    else
        mq.cmd('/togglevariable chainpull 0')
    end
end

function ToggleAutoHideAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable autohide 1')
    else
        mq.cmd('/togglevariable autohide 0')
    end
end

function ToggleAggroAction(isChecked)
    if isChecked then
        mq.cmd('/togglevariable aggroon 1')
    else
        mq.cmd('/togglevariable aggroon 0')
    end
end

mq.imgui.init('Example', DrawMainWindow)

while openGUI do
    if not isPaused then
    end
    mq.delay(1000)
end
