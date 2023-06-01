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
        mq.cmd('/mezon 3')
    else
        mq.cmd('/mezon 0')
    end
end

local function ToggleUseAE(isChecked)
    if isChecked then
        mq.cmd('/togglevariable aeon 1')
    else
        mq.cmd('/togglevariable aeon 0')
    end
end

local function ToggleMelee(isChecked)
    if isChecked then
        mq.cmd('/meleeon 1')
    else
        mq.cmd('/meleeon 2')
    end
end

local function ToggleMedCombat(isChecked)
    if isChecked then
        mq.cmd('/medcombat 1')
    else
        mq.cmd('/medcombat 2')
    end
end

local function ToggleBuffs(isChecked)
    if isChecked then
        mq.cmd('/buffson 1')
    else
        mq.cmd('/buffson 0')
    end
end

local function ToggleRebuff(isChecked)
    if isChecked then
        mq.cmd('/rebuffon 1')
    else
        mq.cmd('/rebuffon 0')
    end
end

local function ToggleAutoFire(isChecked)
    if isChecked then
        mq.cmd('/autofireon 1')
    else
        mq.cmd('/autofireon 0')
    end
end

local function ToggleAutoRez(isChecked)
    if isChecked then
        mq.cmd('/autorezon 1')
    else
        mq.cmd('/autorezon 0')
    end
end

local function ToggleUsePet(isChecked)
    if isChecked then
        mq.cmd('/peton 1')
    else
        mq.cmd('/peton 2')
    end
end

local function TogglePetToys(isChecked)
    if isChecked then
        mq.cmd('/PetToysOn 1')
    else
        mq.cmd('/PetToysOn 0')
    end
end

local function ToggleScatter(isChecked)
    if isChecked then
        mq.cmd('/scatteron 1')
    else
        mq.cmd('/scatteron 0')
    end
end

local function ToggleHeals(isChecked)
    if isChecked then
        mq.cmd('/Healson 1')
    else
        mq.cmd('/Healson 0')
    end
end

local function ToggleCampfire(isChecked)
    if isChecked then
        mq.cmd('/campfire on')
    else
        mq.cmd('/campfire off')
    end
end

local function ToggleGroupEscape(isChecked)
    if isChecked then
        mq.cmd('/togglevariable groupescapeon 1')
    else
        mq.cmd('/togglevariable groupescapeon 0')
    end
end

local function ToggleTwist(isChecked)
    if isChecked then
        mq.cmd('/togglevariable twiston 1')
    else
        mq.cmd('/togglevariable twiston 0')
    end
end

local function ToggleFaceMob(isChecked)
    if isChecked then
        mq.cmd('/togglevariable facemobon 1')
    else
        mq.cmd('/togglevariable facemobon 0')
    end
end

local function ToggleDebuffAll(isChecked)
    if isChecked then
        mq.cmd('/togglevariable debuffallon 1')
    else
        mq.cmd('/togglevariable debuffallon 0')
    end
end

local function ToggleXtarHeal(isChecked)
    if isChecked then
        mq.cmd('/togglevariable xtarheal 1')
    else
        mq.cmd('/togglevariable xtarheal 0')
    end
end

local function ToggleCure(isChecked)
    if isChecked then
        mq.cmd('/togglevariable cureson 1')
    else
        mq.cmd('/togglevariable cureson 0')
    end
end

local function TogglePetShrink(isChecked)
    if isChecked then
        mq.cmd('/togglevariable petshrinkon 1')
    else
        mq.cmd('/togglevariable petshrinkon 0')
    end
end

local function TogglePullTwist(isChecked)
    if isChecked then
        mq.cmd('/togglevariable pulltwiston 1')
    else
        mq.cmd('/togglevariable pulltwiston 0')
    end
end

local function ToggleChainPull(isChecked)
    if isChecked then
        mq.cmd('/togglevariable chainpull 1')
    else
        mq.cmd('/togglevariable chainpull 0')
    end
end

local function ToggleAutoHide(isChecked)
    if isChecked then
        mq.cmd('/togglevariable autohide 1')
    else
        mq.cmd('/togglevariable autohide 0')
    end
end

local function ToggleAggro(isChecked)
    if isChecked then
        mq.cmd('/togglevariable aggroon 1')
    else
        mq.cmd('/togglevariable aggroon 0')
    end
end

local checkboxHandlers = {
    ["Single Mez"] = ToggleSingleMez,
    Chase = ToggleChase,
    ["Return to Camp"] = ToggleReturntoCamp,
    Burn = ToggleBurn,
    ["AE Mez"] = ToggleAEMez,
    ["Use AE"] = ToggleUseAE,
    Melee = ToggleMelee,
    ["Med Combat"] = ToggleMedCombat,
    Buffs = ToggleBuffs,
    Rebuff = ToggleRebuff,
    ["Auto Fire"] = ToggleAutoFire,
    ["Auto Rez"] = ToggleAutoRez,
    ["Use Pet"] = ToggleUsePet,
    ["Pet Toys"] = TogglePetToys,
    Scatter = ToggleScatter,
    Heals = ToggleHeals,
    Campfire = ToggleCampfire,
    ["Group Escape"] = ToggleGroupEscape,
    Twist = ToggleTwist,
    ["Face Mob"] = ToggleFaceMob,
    ["Debuff All"] = ToggleDebuffAll,
    ["Xtar Heal"] = ToggleXtarHeal,
    Cure = ToggleCure,
    ["Pet Shrink"] = TogglePetShrink,
    ["Pull Twist"] = TogglePullTwist,
    ["Chain Pull"] = ToggleChainPull,
    ["Auto Hide"] = ToggleAutoHide,
    Aggro = ToggleAggro
}

return checkboxHandlers
