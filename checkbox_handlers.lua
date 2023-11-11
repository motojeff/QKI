local mq = require('mq')

local function ToggleSingleMez(isChecked)
    if isChecked then
        mq.cmd('/mezon 1')
    else
        mq.cmd('/mezon 0')
    end
end

local function ToggleChase(isChecked)
    if isChecked then
        mq.cmd('/chase on')
    else
        mq.cmd('/chase off')
    end
end

local function ToggleReturntoCamp(isChecked)
    if isChecked then
        mq.cmd('/camphere on')
    else
        mq.cmd('/camphere off')
    end
end

local function ToggleBurn(isChecked)
    if isChecked then
        mq.cmd('/burn on')
    else
        mq.cmd('/burn off')
    end
end

local function ToggleAEMez(isChecked)
    if isChecked then
        mq.cmd('/MezOn 3')
    else
        mq.cmd('/MezOn 0')
    end
end

local function ToggleUseAE(isChecked)
    if isChecked then
        mq.cmd('/togglevariable AEOn 1')
        mq.cmd('/kasettings load ae 1')
        print("USE AE ON")
    else
        mq.cmd('/togglevariable AEOn 0')
        mq.cmd('/kasettings load ae 1')
        print("USE AE OFF")
    end
end

local function ToggleMelee(isChecked)
    if isChecked then
        mq.cmd('/MeleeOn')
    else
        mq.cmd('/MeleeOn')
    end
end

local function ToggleMedCombat(isChecked)
    if isChecked then
        mq.cmd('/MedCombat 1')
    else
        mq.cmd('/MedCombat 2')
    end
end

local function ToggleBuffs(isChecked)
    if isChecked then
        mq.cmd('/BuffsOn 1')
    else
        mq.cmd('/BuffsOn 0')
    end
end

local function ToggleRebuff(isChecked)
    if isChecked then
        mq.cmd('/RebuffOn 1')
    else
        mq.cmd('/RebuffOn 0')
    end
end

local function ToggleAutoFire(isChecked)
    if isChecked then
        mq.cmd('/AutoFireOn 1')
    else
        mq.cmd('/AutoFireOn 0')
    end
end

local function ToggleAutoRez(isChecked)
    if isChecked then
        mq.cmd('/AutoRezon 1')
    else
        mq.cmd('/AutoRezon 0')
    end
end

local function ToggleUsePet(isChecked)
    if isChecked then
        mq.cmd('/PetOn on')
    else
        mq.cmd('/PetOn off')
    end
end

local function TogglePetToys(isChecked)
    if isChecked then
        mq.cmd('/PetToysOn on')
    else
        mq.cmd('/PetToysOn off')
    end
end

local function ToggleScatter(isChecked)
    if isChecked then
        mq.cmd('/togglevariable scatteron 1')
        mq.cmd('/kasettings load')
        print("Scatter On")
    else
        mq.cmd('/togglevariable scatteron 0')
        mq.cmd('/kasettings load')
        print("Scatter Off")
    end
end

local function ToggleHeals(isChecked)
    if isChecked then
        mq.cmd('/HealsOn 1')
    else
        mq.cmd('/HealsOn 0')
    end
end

local function ToggleCampfire(isChecked)
    if isChecked then
        mq.cmd('/togglevariable CampfireOn 1')
        print("Making a campfire")
        mq.cmd('/kasettings load')
    else
        mq.cmd('/togglevariable CampfireOn 0')
        print("Will NOT Make a Campfire")
        mq.cmd('/kasettings load')
    end
end

local function ToggleGroupEscape(isChecked)
    if isChecked then
        mq.cmd('/togglevariable GroupEscapeOn 1')
        mq.cmd('/kasettings load')
        print("Group Escape On")
    else
        mq.cmd('/togglevariable GroupEscapeOn 0')
        mq.cmd('/kasettings load')
        print("Group Escape Off")
    end
end

local function ToggleTwist(isChecked)
    if isChecked then
        mq.cmd('/togglevariable TwistOn 1')
        mq.cmd('/kasettings load')
        print("Twisting Out Of Combat")
    else
        mq.cmd('/togglevariable TwistOn 0')
        mq.cmd('/kasettings load')
        print("Do NOT Twist Out of Combat")
    end
end

local function ToggleFaceMob(isChecked)
    if isChecked then
        mq.cmd('/togglevariable FaceMobOn 1')
        mq.cmd('/kasettings load melee 1')
        print("Face Mob On")
    else
        mq.cmd('/togglevariable FaceMobOn 0')
        mq.cmd('/kasettings load melee 1')
        print("Face Mob Off")
    end
end

local function ToggleDebuffAll(isChecked)
    if isChecked then
        mq.cmd('/togglevariable DebuffAllOn 1')
        mq.cmd('/kasettings load dps 1')
        print("DeBuff All On")
    else
        mq.cmd('/togglevariable DebuffAllOn 0')
        mq.cmd('/kasettings load dps 1')
        print("DeBuff All Off")
    end
end

local function ToggleXtarHeal(isChecked)
    if isChecked then
        mq.cmd('/togglevariable XTarHeal 1')
        mq.cmd('/kasettings load heals 1')
        print("Healing GRP and Xtar")
    else
        mq.cmd('/togglevariable XTarHeal 0')
        mq.cmd('/kasettings load heals 1')
        print("Healing GRP ONLY")
    end
end

local function ToggleCure(isChecked)
    if isChecked then
        mq.cmd('/togglevariable CuresOn 1')
        mq.cmd('/kasettings load cures 1')
        print("Using Cure")
    else
        mq.cmd('/togglevariable CuresOn 0')
        mq.cmd('/kasettings load cures 1')
        print("Not Using Cure")
    end
end

local function TogglePetShrink(isChecked)
    if isChecked then
        mq.cmd('/togglevariable PetShrinkOn 1')
        mq.cmd('/kasettings load Pet 1')
        print("Shrink Pet On")
    else
        mq.cmd('/togglevariable PetShrinkOn 0')
        mq.cmd('/kasettings load pet 1')
        print("Shrink Pet Off")
    end
end

local function TogglePullTwist(isChecked)
    if isChecked then
        mq.cmd('/togglevariable PullTwistOn 1')
        mq.cmd('/kasettings load pull 1')
        print("Pull With Twist On")
    else
        mq.cmd('/togglevariable PullTwistOn 0')
        mq.cmd('/kasettings load pull 1')
        print("Pull With Twist Off")
    end
end

local function ToggleChainPull(isChecked)
    if isChecked then
        mq.cmd('/togglevariable ChainPull 1')
        mq.cmd('/kasettings load pull 1')
        print("Chain Pull On")
    else
        mq.cmd('/togglevariable ChainPull 0')
        mq.cmd('/kasettings load pull 1')
        print("Chain Pull Off")
    end
end

local function ToggleAutoHide(isChecked)
    if isChecked then
        mq.cmd('/togglevariable AutoHide 1')
        mq.cmd('/kasettings load')
        print("Auto Hide On")
    else
        mq.cmd('/togglevariable AutoHide 0')
        mq.cmd('/kasettings load')
        print("Auto Hide Off")
    end
end

local function ToggleAggro(isChecked)
    if isChecked then
        mq.cmd('/togglevariable AggroOn 1')
        mq.cmd('/kasettings load aggro')
        print("Use INI Aggro Section On")
    else
        mq.cmd('/togglevariable AggroOn 0')
        mq.cmd('/kasettings load aggro')
        print("Use INI Aggro Section Off")

    end
end

local checkboxHandlers = {
    ["BurnAllNamed"] = ToggleBurn,
    ["AutoFireOn"] = ToggleAutoFire,
    ["AEOn"] = ToggleUseAE,
    ["MeleeOn"] = ToggleMelee,
    ["Single Mez"] = ToggleSingleMez,
    ["AE Mez"] = ToggleAEMez,
    ["ReturnToCamp"] = ToggleReturntoCamp,
    ["ChaseAssist"] = ToggleChase,
    ["ChainPull"] = ToggleChainPull,
    ["PullTwistOn"] = TogglePullTwist,
    ["TwistOn"] = ToggleTwist,
    ["FaceMobOn"] = ToggleFaceMob,
    ["ScatterOn"] = ToggleScatter,
    ["GroupEscapeOn"] = ToggleGroupEscape,
    ["XTarHeal"] = ToggleXtarHeal,
    ["HealsOn"] = ToggleHeals,
    ["CuresOn"] = ToggleCure,
    ["AutoRezOn"] = ToggleAutoRez,
    ["DebuffAllOn"] = ToggleDebuffAll,
    ["BuffsOn"] = ToggleBuffs,
    ["RebuffOn"] = ToggleRebuff,
    ["AutoHide"] = ToggleAutoHide,
    ["MedCombat"] = ToggleMedCombat,
    ["PetOn"] = ToggleUsePet,
    ["PetToys"] = TogglePetToys,
    ["PetShrinkOn"] = TogglePetShrink,
    ["AggroOn"] = ToggleAggro,
    ["CampfireOn"] = ToggleCampfire
}

return checkboxHandlers
