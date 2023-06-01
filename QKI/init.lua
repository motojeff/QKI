local mq = require('mq')
require 'ImGui'
local checkboxHandlers = require('checkbox_handlers')

local windowWidth = 1150
local windowHeight = 250
local checkboxColumnWidth = 100
local buttonColumnWidth = 1200

local openGUI = true
local shouldDrawGUI = true
local stuffLabels = {
    "Burn", "Auto Fire", "Use AE", "Melee", "Single Mez", "AE Mez", "Return Camp",
    "Chase", "Chain Pull", "Pull Twist", "Twist", "Face Mob", "Scatter", "Group Escape",
    "Xtar Heal", "Heals", "Cure", "AutoRez", "Debuff All", "Buffs", "ReBuff",
    "Auto Hide", "Med Combat", "Use Pet", "Pet Toys", "Pet Shrink", "Aggro", "Camp Fire"
}

local checkboxStates = {
    Burn = false,
    SingleMez = false,
    AEMez = false,
    UseAE = false,
    AutoFire = false,
    Melee = false,
    MedCombat = false,
    Buffs = false,
    Rebuff = false,
    UsePet = false,
    PetToys = false,
    PetShrink = false,
    ReturntoCamp = false,
    Scatter = false,
    Chase = false,
    ChainPull = false,
    AutoHide = false,
    PullTwist = false,
    Twist = false,
    FaceMob = false,
    Campfire = false,
    GroupEscape = false,
    DebuffAll = false,
    Heals = false,
    XtarHeal = false,
    Cure = false,
    AutoRez = false,
    Aggro = false
}

local setRadius = ""
local setArc = ""
local setMed = ""
local setAssist = ""
local setZrange = ""

local function DrawMainWindow()
    if not openGUI then return end
    ImGui.SetNextWindowSize(windowWidth, windowHeight)
    openGUI, shouldDrawGUI = ImGui.Begin('Quicky Kiss It 1.3', openGUI)
    if shouldDrawGUI then
        ImGui.Text("Make Sure Kissassist Is Running!")

        ImGui.Columns(5, 'Columns', false)

        ImGui.SetColumnWidth(0, checkboxColumnWidth)
        for i = 1, 7 do
            local label = stuffLabels[i]
            local isChecked = checkboxStates[label]
            local newValue, valueChanged = ImGui.Checkbox(label, isChecked)
            if valueChanged then
                checkboxStates[label] = newValue
                local handler = checkboxHandlers[label]
                if handler then
                    handler(newValue)
                end
            end
        end

        ImGui.SameLine()
        ImGui.NextColumn()
        ImGui.SetColumnWidth(1, checkboxColumnWidth)
        for i = 8, 14 do
            local label = stuffLabels[i]
            local isChecked = checkboxStates[label]
            local newValue, valueChanged = ImGui.Checkbox(label, isChecked)
            if valueChanged then
                checkboxStates[label] = newValue
                local handler = checkboxHandlers[label]
                if handler then
                    handler(newValue)
                end
            end
        end

        ImGui.SameLine()
        ImGui.NextColumn()
        ImGui.SetColumnWidth(2, checkboxColumnWidth)
        for i = 15, 21 do
            local label = stuffLabels[i]
            local isChecked = checkboxStates[label]
            local newValue, valueChanged = ImGui.Checkbox(label, isChecked)
            if valueChanged then
                checkboxStates[label] = newValue
                local handler = checkboxHandlers[label]
                if handler then
                    handler(newValue)
                end
            end
        end

        ImGui.SameLine()
        ImGui.NextColumn()
        ImGui.SetColumnWidth(3, checkboxColumnWidth)
        for i = 22, 28 do
            local label = stuffLabels[i]
            local isChecked = checkboxStates[label]
            local newValue, valueChanged = ImGui.Checkbox(label, isChecked)
            if valueChanged then
                checkboxStates[label] = newValue
                local handler = checkboxHandlers[label]
                if handler then
                    handler(newValue)
                end
            end
        end

        ImGui.SameLine()
        ImGui.NextColumn()
        ImGui.SetColumnWidth(4, buttonColumnWidth)
        if isPaused then
            if ImGui.SmallButton("Resume") then
                mq.cmd('/mqp off')
                isPaused = false
            end
        else
            if ImGui.SmallButton("Pause") then
                mq.cmd('/mqp on')
                isPaused = true
            end
        end

        ImGui.SameLine()

        if ImGui.SmallButton("STOP!") then
            mq.cmd(
                '/squelch /multiline ; /end; /afollow off; /stick off; /moveto off; /nav stop; /play off; /mqp on; /attack off; /twist off;')
        end

        ImGui.SameLine()

        if ImGui.SmallButton("Restart Kiss") then
            mq.cmd('/mac kissassist')
        end

        ImGui.SameLine()

        if ImGui.SmallButton("Start Kiss as Puller") then
            mq.cmd('/mac kissassist puller')
        end

        ImGui.SameLine()

        if ImGui.SmallButton("Ignore Target") then
            mq.cmd('/addignore "${Target.CleanName}"')
        end

        ImGui.SameLine()

        if ImGui.SmallButton("AddPull Target") then
            mq.cmd('/addpull "${Target.CleanName}"')
        end

        ImGui.SameLine()

        if ImGui.SmallButton("Add Immune") then
            mq.cmd('/addimmune "${Target.CleanName}"')
        end

        ImGui.SameLine()

        if ImGui.SmallButton("Force Rebuff") then
            mq.cmd('/buffgroup')
        end

        ImGui.NewLine()
        ImGui.SetNextItemWidth(50)
        setRadius = ImGui.InputText('##setRadius', setRadius)

        ImGui.SameLine()
        if ImGui.SmallButton('Set Radius') then
            mq.cmd('/maxradius ', setRadius)
        end

        ImGui.SameLine()
        ImGui.SetNextItemWidth(50)
        setArc = ImGui.InputText('##setArc', setArc)

        ImGui.SameLine()
        if ImGui.SmallButton('Set Pull Arc') then
            mq.cmd('/setpullarc ', setArc)
        end

        ImGui.SameLine()
        ImGui.SetNextItemWidth(50)
        setZrange = ImGui.InputText('##setZrange', setZrange)

        ImGui.SameLine()
        if ImGui.SmallButton('Set Z Range') then
            mq.cmd('/maxzrange ', setZrange)
        end

        ImGui.SameLine()
        ImGui.SetNextItemWidth(50)
        setMed = ImGui.InputText('##setMed', setMed)

        ImGui.SameLine()
        if ImGui.SmallButton('Med Start') then
            mq.cmd('/medstart ', setMed)
        end

        ImGui.SameLine()
        ImGui.SetNextItemWidth(50)
        setAssist = ImGui.InputText('##setAssist', setAssist)

        ImGui.SameLine()
        if ImGui.SmallButton('Assist At') then
            mq.cmd('/assistat ', setAssist)
        end
    end
    ImGui.End()
end

function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

mq.imgui.init('QKI', DrawMainWindow)

while openGUI do
    mq.delay(1000)
end
