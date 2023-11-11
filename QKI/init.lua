local mq = require('mq')
require 'ImGui'
local checkboxHandlers = require('checkbox_handlers')
local windowWidth = 1150
local windowHeight = 250
local buttonColumnWidth = 1200
local selectedPath = ""
local openGUI = true
local shouldDrawGUI = true

local stuffLabels = {
    "BurnAllNamed", "AutoFireOn", "AEOn", "MeleeOn", "Single Mez", "AE Mez", "ReturnToCamp",
    "ChaseAssist", "ChainPull", "PullTwistOn", "TwistOn", "FaceMobOn", "ScatterOn", "GroupEscapeOn",
    "XTarHeal", "HealsOn", "CuresOn", "AutoRezOn", "DebuffAllOn", "BuffsOn", "RebuffOn",
    "AutoHide", "MedCombat", "PetOn", "PetToys", "PetShrinkOn", "AggroOn", "CampfireOn"
}

local displayLabels = {
    BurnAllNamed = "Burn",
    AutoFireOn = "Auto Fire",
    AEOn = "Use AE",
    MeleeOn = "Melee",
    SingleMez = "Single Mez",
    AEMez = "AE Mez",
    ReturnToCamp = "Return Camp",
    ChaseAssist = "Chase",
    ChainPull = "Chain Pull",
    PullTwistOn = "Pull Twist",
    TwistOn = "Twist",
    FaceMobOn = "Face Mob",
    ScatterOn = "Scatter",
    GroupEscapeOn = "Group Escape",
    XTarHeal = "Xtar Heal",
    HealsOn = "Heals",
    CuresOn = "Cure",
    AutoRezOn = "AutoRez",
    DebuffAllOn = "Debuff All",
    BuffsOn = "Buffs",
    RebuffOn = "ReBuff",
    AutoHide = "Auto Hide",
    MedCombat = "Med Combat",
    PetOn = "Use Pet",
    PetToys = "Pet Toys",
    PetShrinkOn = "Pet Shrink",
    AggroOn = "Aggro",
    CampfireOn = "Camp Fire"
}

local checkboxStates = {
    BurnAllNamed = false,
    AutoFireOn = false,
    AEOn = false,
    MeleeOn = false,
    ["Single Mez"] = false, -- Is this even working?
    ["AE Mez"] = false,
    ReturnToCamp = false,
    ChaseAssist = false,
    ChainPull = false,
    PullTwistOn = false,
    TwistOn = false,
    FaceMobOn = false,
    ScatterOn = false,
    GroupEscapeOn = false,
    XTarHeal = false,
    HealsOn = false,
    CuresOn = false,
    AutoRezOn = false,
    DebuffAllOn = false,
    BuffsOn = false,
    RebuffOn = false,
    AutoHide = false,
    MedCombat = false,
    PetOn = false, -- Check this
    PetToys = false,
    PetShrinkOn = false,
    AggroOn = false,
    CampfireOn = false
}

local setRadius = ""
local setArc = ""
local setMed = ""
local setAssist = ""
local setZrange = ""
local setMezradius = ""
local setStophp = ""
local CampRadius = ""
local ChaseDistance = ""

function parseIniFile(filePath)
    local settings = {}
    local file, err = io.open(filePath, "r")
    if not file then
        return nil, "Unable to open file: " .. err
    end

    for line in file:lines() do
        -- Ignore comments and empty lines in ini file
        if not line:match("^%s*[;#]") and line:match("%S") then
            local key, value = line:match("^%s*([^=]+)%s*=%s*(.+)%s*$")
            if key and value then
                settings[key:match("^%s*(.-)%s*$")] = value:match("^%s*(.-)%s*$")
            end
        end
    end

    file:close()
    --Debuging Displays loaded ENTIRE ini values in console when loaded
    --for k, v in pairs(settings) do
    --    print(k, v)
    --end
    return settings
end

function openFileDialog()
    local tempFilePath = "selectedFilePath.txt"
    local command =
    'powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object System.Windows.Forms.OpenFileDialog; $null = $dialog.ShowDialog(); $dialog.FileName > ' ..
    tempFilePath .. '"'
    os.execute(command)

    local file = io.open(tempFilePath, "r")
    if file then
        selectedPath = file:read("*a"):match("^%s*(.-)%s*$")
        file:close()
        os.remove(tempFilePath)

        -- Remove non-printable characters
        selectedPath = selectedPath:gsub("[%z\1-\31\128-\255]", "")

        -- Convert backslashes to double backslashes
        selectedPath = selectedPath:gsub("\\", "\\\\")

        -- Hexadecimal debug
        --for i = 1, #selectedPath do
        --    print(string.format("%x ", string.byte(selectedPath, i)))
        --end

        print("Processed file path: " .. selectedPath)
    end

    return selectedPath
end

function saveSettingsToIniFile(filePath)
    local managedSettings = {
        MaxRadius = "MaxRadius=" .. setRadius,
        PullArcWidth = "PullArcWidth=" .. setArc,
        MedStart = "MedStart=" .. setMed,
        AssistAt = "AssistAt=" .. setAssist,
        MaxZRange = "MaxZRange=" .. setZrange,
        MezRadius = "MezRadius=" .. setMezradius,
        MezStopHPs = "MezStopHPs=" .. setStophp,
    }
    for key, value in pairs(checkboxStates) do
        managedSettings[key] = key .. "=" .. (value and "1" or "0")
    end

    local lines = {}
    local file, err = io.open(filePath, "r")
    if file then
        for line in file:lines() do
            local key = line:match("^%s*([^=]+)%s*=")
            if key and managedSettings[key] then
                table.insert(lines, managedSettings[key])
            else
                table.insert(lines, line)
            end
        end
        file:close()
    else
        print("Error reading file for updating: " .. (err or "Unknown error"))
        return
    end

    file, err = io.open(filePath, "w")
    if file then
        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end
        file:close()
    else
        print("Error writing file: " .. (err or "Unknown error"))
    end
end

local function DrawMainWindow()
    if not openGUI then return end
    ImGui.SetNextWindowSize(windowWidth, windowHeight)
    openGUI, shouldDrawGUI = ImGui.Begin('Quicky Kiss It 2.0', openGUI)
    if shouldDrawGUI then
        ImGui.Text("Make Sure Kissassist Is Running!")

        ImGui.Columns(5, 'Columns', false)

        local checkboxesPerColumn = 7
        local column = 1
        local desiredColumnWidth = 100 -- Checkbox Column Width

        for i, key in ipairs(stuffLabels) do
            if i > (checkboxesPerColumn * column) then
                ImGui.NextColumn()
                column = column + 1
            end

            if i <= checkboxesPerColumn * column then
                ImGui.SetColumnWidth(column - 1, desiredColumnWidth)
            end

            local displayLabel = displayLabels[key] or key
            local isChecked = checkboxStates[key]
            local newValue, valueChanged = ImGui.Checkbox(displayLabel, isChecked)
            if valueChanged then
                checkboxStates[key] = newValue
                local handler = checkboxHandlers[key]
                if handler then
                    handler(newValue)
                end
            end
        end

        ImGui.SameLine()
        ImGui.NextColumn()
        ImGui.SetColumnWidth(4, buttonColumnWidth)
        if isPaused then
            ImGui.PushStyleColor(ImGuiCol.Button, 1.0, 0.0, 0.0, 1.0) -- RGBA red
            if ImGui.Button("Resume") then
                mq.cmd('/mqp off')
                isPaused = false
            end
            ImGui.PopStyleColor()
        else
            if ImGui.Button("Pause") then
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

        ImGui.NewLine()
        ImGui.SetNextItemWidth(50)
        setMezradius = ImGui.InputText('##setMezRadius', setMezradius)

        ImGui.SameLine()
        if ImGui.SmallButton('Mez Radius') then
            if selectedPath and selectedPath ~= "" then
                saveSettingsToIniFile(selectedPath)
                mq.cmd('/kasettings load mez 1')
            else
                print("No file path selected to save settings.")
            end
        end

        ImGui.SameLine()
        ImGui.SetNextItemWidth(50)
        setStophp = ImGui.InputText('##setStophp', setStophp)

        ImGui.SameLine()
        if ImGui.SmallButton('Mez Stop HP') then
            if selectedPath and selectedPath ~= "" then
                saveSettingsToIniFile(selectedPath)
                mq.cmd('/kasettings load mez 1')
            else
                print("No file path selected to save settings.")
            end
        end
        ImGui.SameLine()
        if ImGui.SmallButton("Add Immune") then
            mq.cmd('/addimmune "${Target.CleanName}"')
        end

        ImGui.SameLine()
        ImGui.SetNextItemWidth(50)
        CampRadius = ImGui.InputText('##sCampRadius', CampRadius)

        ImGui.SameLine()
        if ImGui.SmallButton('Camp Radius') then
            mq.cmd('/CampRadius ', CampRadius)
            mq.cmd('/kasettings load')
        end

        ImGui.SameLine()
        ImGui.SetNextItemWidth(50)
        ChaseDistance = ImGui.InputText('##sChaseDistance', ChaseDistance)

        ImGui.SameLine()
        if ImGui.SmallButton('Chase Distance') then
            mq.cmd('/ChaseDistance ', ChaseDistance)
            mq.cmd('/kasettings load')
        end
    end
    ImGui.NewLine()
    if ImGui.Button("Load INI File") then
        local filePath = openFileDialog()
        if filePath and filePath ~= "" then
            local settings, err = parseIniFile(filePath)
            if settings then
                print("Loaded settings from INI file")
                for key, _ in pairs(checkboxStates) do
                    if key == "Single Mez" or key == "AE Mez" then
                    elseif settings[key] ~= nil then
                        checkboxStates[key] = settings[key] == "1"
                        print("Updated checkboxStates:", key, checkboxStates[key])
                    else
                        print("INI file does not contain a setting for:", key)
                    end
                end

                -- Special handling for MezOn
                if settings["MezOn"] ~= nil then
                    local mezValue = tonumber(settings["MezOn"])
                    if mezValue then
                        checkboxStates["Single Mez"] = (mezValue == 1 or mezValue == 2)
                        checkboxStates["AE Mez"] = (mezValue == 1 or mezValue == 3)
                        print("Updated checkboxStates for MezOn:", "Single Mez", checkboxStates["Single Mez"],
                            "AE Mez", checkboxStates["AE Mez"])
                    else
                        print("INI file does not contain a valid number for MezOn")
                    end
                else
                    print("INI file does not contain a setting for MezOn")
                end

                setRadius = settings["MaxRadius"] or setRadius
                setArc = settings["PullArcWidth"] or setArc
                setMed = settings["MedStart"] or setMed
                setAssist = settings["AssistAt"] or setAssist
                setZrange = settings["MaxZRange"] or setZrange
                setMezradius = settings["MezRadius"] or setMezradius
                setStophp = settings["MezStopHPs"] or setStophp
                CampRadius = settings["CampRadius"] or CampRadius
                ChaseDistance = settings["ChaseDistance"] or ChaseDistance

                -- Print updates for input fields on ini load for debugging
                print("Updated input field setRadius:", setRadius)
                print("Updated input field setMed:", setMed)
                print("Updated input field setAssist:", setAssist)
                print("Updated input field setZrange:", setZrange)
                print("Updated input field setRadius:", setRadius)
                print("Updated input field setMezradius:", setMezradius)
                print("Updated input field setStophp:", setStophp)
                print("Updated input field CampRadius:", CampRadius)
                print("Updated input field ChaseDistance:", ChaseDistance)
            else
                print("Error loading INI file: " .. (err or "Unknown error"))
            end
        end
    end
    ImGui.SameLine()
    if ImGui.SmallButton('Edit INI') then
        mq.cmd('/kissedit')
    end
    ImGui.End()
end

for key, value in pairs(checkboxStates) do
    local changed, newValue = ImGui.Checkbox(key, value)
    if changed then
        checkboxStates[key] = newValue
    end
end

function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

mq.imgui.init('QKI', DrawMainWindow)

while openGUI do
    mq.delay(16)
end
