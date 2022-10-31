EmoteMenu = {
    PlayerId = PlayerId(),
    GameBuild = GetGameBuildNumber(),
    CurrentWalk = GetResourceKvpString('animations_walkstyle') or 'default', -- Waiting on https://github.com/citizenfx/fivem/pull/1644 to be merged to improve this.
    isActionsLimited = false,
    IsPlayingAnimation = false,
    IsRagdoll = false,
    IsCrouched = false,
    PtfxCanHold = false,
    PlayerProps = {},
    PlayerParticles = {},
    Keybinds = {},
    RegisteredEmotes = {}
}

-- Menu Options
local mainMenuOptions, emoteMenuOptions = { -- placeholder descriptions are currently required for the item list descriptions.
    -- Main Menu
    {label = 'Search', description = 'Search for animations', icon = 'fa-solid fa-magnifying-glass', args = 'animations_search'},
    {label = 'Emote Menu', description = 'Open the emote menu', icon = 'fa-solid fa-person', args = 'animations_emote_menu'},
    {label = 'Walking Styles', description = 'placeholder', icon = 'fa-solid fa-person-walking', values = {}, args = 'Walks', close = false},
    {label = 'Scenarios', description = 'placeholder', icon = 'fa-solid fa-person-walking-with-cane', values = {}, args = 'Scenarios', close = false},
    {label = 'Facial Expressions', description = 'placeholder', icon = 'fa-solid fa-face-angry', values = {}, args = 'Expressions', close = false},
    {label = 'Cancel', description = 'placeholder', values = {{label = 'Emote', description = 'Cancel your emote'}, {label = 'Walk Style', description = 'Reset your walk style'}, {label = 'Expression', description = 'Reset your expression'}, {label = 'All', description = 'Cancel and reset everything'}}, icon = 'fa-solid fa-ban', args = 'cancel', close = false}
}, {
    -- Emote Menu
    {label = 'Emotes', description = 'placeholder', icon = 'fa-solid fa-person-walking', values = {}, args = 'Emotes', close = false},
    {label = 'Prop Emotes', description = 'placeholder', icon = 'fa-solid fa-person-hiking', values = {}, args = 'PropEmotes', close = false},
    {label = 'Dance Emotes', description = 'placeholder', icon = 'fa-solid fa-person-running', values = {}, args = 'DanceEmotes', close = false},
    {label = 'Synchronized Emotes', description = 'placeholder', icon = 'fa-solid fa-people-carry', values = {}, args = 'SynchronizedEmotes', close = false},
    {label = 'Animal Emotes', description = 'placeholder', icon = 'fa-solid fa-dog', values = {}, args = 'AnimalEmotes', close = false}
}

-- Functions

---Opens the animation menu
function EmoteMenu.OpenMenu()
    lib.showMenu('animations_main_menu')
end
exports('OpenMenu', EmoteMenu.OpenMenu)

---Closes the animation menu
function EmoteMenu.CloseMenu()
    lib.hideMenu()
end
exports('CloseMenu', EmoteMenu.CloseMenu)

---Toggle player limitations
---@param limited boolean
function EmoteMenu.ToggleLimitation(limited)
    EmoteMenu.isActionsLimited = limited
end
exports('ToggleLimitation', EmoteMenu.ToggleLimitation)

---Check if the player is currently limited
---@return boolean
function EmoteMenu.IsLimited()
    return EmoteMenu.isActionsLimited
end
exports('IsLimited', EmoteMenu.IsLimited)

---Remove multiple entries from a table
---@param _table table
---@param keep function
function EmoteMenu.RemoveFromTable(_table, keep)
    local _index = 1
    for i = 1, #_table do
        if keep(_table, i) then
            if (i ~= _index) then
                _table[_index] = _table[i]
                _table[i] = nil
            end
            _index += 1
        else
            _table[i] = nil
        end
    end
    return _table
end

---Display a notification
---@param _type string
---@param message string
function EmoteMenu.Notify(_type, message)
    lib.notify({
        description = message,
        position = Config.NotificationPosition,
        duration = 2500,
        style = {
            backgroundColor = '#141517',
            color = '#d6d6d6'
        },
        icon = _type == 'error' and 'ban' or 'circle-exclamation',
        iconColor = _type == 'error' and '#D30000' or '#2ea4f7'
    })
end

---Displays a text UI
---@param icon string
---@param text string
function EmoteMenu.ShowHelpAlert(icon, text)
    lib.showTextUI(text, {
        position = Config.HelpAlertPosition,
        icon = icon,
        style = {
            borderRadius = 0,
            backgroundColor = '#141517',
            color = 'white'
        }
    })
end

---Register emotes to be used within external resources
---@param _type string
---@param emote table
function EmoteMenu.RegisterEmote(emote)
    EmoteMenu.RegisteredEmotes[emote.Name] = emote
end
exports('RegisterEmote', EmoteMenu.RegisterEmote)

---Play a registered emote
---@param emote string
function EmoteMenu.PlayRegisteredEmote(emote)
    local registeredEmote = EmoteMenu.RegisteredEmotes[emote]
    if not registeredEmote then
        EmoteMenu.Notify('error', 'That isn\'t a valid registered emote, please inform the server owner')
        return
    end
    if registeredEmote.Type == 'Walks' then
        EmoteMenu.SetWalk(registeredEmote.Walk)
    else
        EmoteMenu.Play(registeredEmote.Type, registeredEmote, registeredEmote.Variant)
    end
end
exports('PlayRegisteredEmote', EmoteMenu.PlayRegisteredEmote)

---Remove emotes from the menu
---@param _type string
function EmoteMenu.RemoveEmotes(_type)
    local checkMenus = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }
    for i = 1, #checkMenus do
        AnimationList[checkMenus[i]] = EmoteMenu.RemoveFromTable(AnimationList[checkMenus[i]], function(_table, _index)
            return not _table[_index][_type]
        end)
    end
end

---Add emotes to the menu
---@param _type string
---@param command string
function EmoteMenu.AddEmotesToMenu(_type, command)
    for option = 1, #mainMenuOptions do
        if mainMenuOptions[option].args == _type then
            for emote = 1, #AnimationList[_type] do
                local _emote = AnimationList[_type][emote]
                if _emote then
                    mainMenuOptions[option].values[#mainMenuOptions[option].values + 1] = {label = _emote.Label, description = ('%s %s'):format(command, _emote.Command)}
                end
            end
            break
        end
    end
    for option = 1, #emoteMenuOptions do
        if emoteMenuOptions[option].args == _type then
            for emote = 1, #AnimationList[_type] do
                local _emote = AnimationList[_type][emote]
                if _emote then
                    emoteMenuOptions[option].values[#emoteMenuOptions[option].values + 1] = {label = _emote.Label, description = ('%s %s'):format(command, _emote.Command)}
                end
            end
            break
        end
    end
end

---Remove attached props on the player
function EmoteMenu.RemoveProps()
    for i = 1, #EmoteMenu.PlayerProps do
        DeleteEntity(EmoteMenu.PlayerProps[i])
    end
    EmoteMenu.PlayerProps = {}
end

---Get an emote based on the command
---@param name string
---@return string _type Emote type
---@return table _emote Emote table
function EmoteMenu.GetEmoteByCommand(name)
    local _type, _emote, checkMenus = nil, nil, {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }
    for i = 1, #checkMenus do
        local animType = checkMenus[i]
        local animList = AnimationList[animType]
        for emote = 1, #animList do
            if animList[emote] and (animList[emote].Command == name) then
                _type, _emote = animType, animList[emote]
                break
            end
        end
    end
    return _type, _emote
end

---Check if the player is in an animation
---@return boolean
function EmoteMenu.IsInAnimation()
    return EmoteMenu.IsPlayingAnimation
end
exports('IsInAnimation', EmoteMenu.IsInAnimation)

function EmoteMenu.RequestSynchronizedEmote(data)
    local playerPos = GetEntityCoords(cache.ped)
    local targetId, targetPed, targetPos = lib.getClosestPlayer(playerPos, 3.0, false)
    if not targetId then
        EmoteMenu.Notify('error', 'No player nearby!')
        return
    end
    local _type, emote = EmoteMenu.GetEmoteByCommand(data.Options.OtherAnimation)
    if _type ~= 'SynchronizedEmotes' then
        EmoteMenu.Notify('error', 'That isn\'t a valid synchronized emote, please inform the server owner')
        return
    end
    TriggerServerEvent('dpemotes:requestSynchronizedEmote', GetPlayerServerId(targetId), data, emote)
end

---Play an emote by command
---@param command string
---@param variant number
function EmoteMenu.PlayByCommand(command, variant)
    local _type, emote = EmoteMenu.GetEmoteByCommand(command)
    if not _type or (_type == 'Walks') then
        EmoteMenu.Notify('error', 'That isn\'t a valid emote')
        return
    end
    EmoteMenu.Play(_type, emote, variant)
end
exports('PlayByCommand', EmoteMenu.PlayByCommand)

---Play an animation
---@param _type string
---@param data table
---@param variation number
function EmoteMenu.Play(_type, data, variation)
    if _type == 'SynchronizedEmotes' then
        EmoteMenu.Notify('error', 'Synchronized emotes are a WIP, please disable them!')
        return
    end
    if data.Expression then
        SetFacialIdleAnimOverride(cache.ped, data.Expression, 0)
        return
    end

    local isInVehicle = IsPedInAnyVehicle(cache.ped, true)
    local duration, movementFlag = nil, isInVehicle and 51 or 0
    if not Config.AllowedInVehicles and isInVehicle then
        EmoteMenu.Notify('error', 'You can\'t play animations in vehicles!')
        return
    end

    if #EmoteMenu.PlayerProps > 0 then
        EmoteMenu.RemoveProps()
    end

    if data.Scenario then
        if isInVehicle then 
            EmoteMenu.Notify('error', 'You can\'t play scenarios in vehicles!')
            return 
        end
        ClearPedTasks(cache.ped)
        TaskStartScenarioInPlace(cache.ped, data.Scenario, 0, true)
        EmoteMenu.IsPlayingAnimation = true
        return
    end

    local isValid = lib.requestAnimDict(data.Dictionary, 1000)
    if not isValid then
        EmoteMenu.Notify('error', 'That isn\'t a valid emote')
        return
    end

    if data.Options then
        duration = data.Options.Duration

        if data.Options.Delay then Wait(data.Options.Delay) end

        if not isInVehicle and data.Options.Flags then
            if data.Options.Flags.Loop then movementFlag = 1 end
            if data.Options.Flags.Move then movementFlag = 51 end
            if data.Options.Flags.Stuck then movementFlag = 50 end
        end

        if data.Options.Ptfx then
            EmoteMenu.PtfxCanHold = data.Options.Ptfx.CanHold
            if Config.PtfxKeybind then 
                EmoteMenu.Keybinds.PlayPtfx:disable(false)
                EmoteMenu.Notify('success', ('Press %s to use the effect!'):format(GetControlInstructionalButton(0, joaat('+playptfx') | 0x80000000, 1):sub(3)))
            end
            TriggerServerEvent('dpemotes:syncPtfx', data.Options.Ptfx.Asset, data.Options.Ptfx.Name, data.Options.Ptfx.Placement[1], data.Options.Ptfx.Placement[2], data.Options.Ptfx.Placement[3])
        else
            if Config.PtfxKeybind then EmoteMenu.Keybinds.PlayPtfx:disable(true) end
        end
    end

    TaskPlayAnim(cache.ped, data.Dictionary, data.Animation, 2.0, 2.0, duration or -1, movementFlag, 0, false, false, false)
    RemoveAnimDict(data.Dictionary)
    EmoteMenu.IsPlayingAnimation = true

    if data.Options and data.Options.Props then
        local propCount = #data.Options.Props
        if propCount > 0 then
            Wait(duration or 0)
            for i = 1, propCount do
                local prop = data.Options.Props[i]
                local variant = prop.Variant
                if variation then
                    if prop.Variations and prop.Variations[variation] then
                        variant = prop.Variations[variation] 
                    end
                end
                local object = EmoteMenu.AddPropToPlayer(prop.Name, prop.Bone, prop.Placement, variant)
                if (i == 1) and (data.Options.Ptfx and data.Options.Ptfx.AttachToProp) then
                    TriggerServerEvent('dpemotes:syncProp', ObjToNet(object))
                end
            end
        end
    end
end
exports('Play', EmoteMenu.Play)

---Cancel the animation you're currently playing
function EmoteMenu.CancelAnimation()
    if EmoteMenu.IsPlayingAnimation then
        if IsPedUsingAnyScenario() then ClearPedTasksImmediately(cache.ped) end
        if LocalPlayer.state.ptfx then LocalPlayer.state:set('ptfx', false, true) end
        if Config.PtfxKeybind then EmoteMenu.Keybinds.PlayPtfx:disable(true) end
        ClearPedTasks(cache.ped)
        DetachEntity(cache.ped, true, false)
        EmoteMenu.RemoveProps()
        EmoteMenu.IsPlayingAnimation = false
    end
end
exports('CancelAnimation', EmoteMenu.CancelAnimation)

---Get the players current walk style
---@return string
function EmoteMenu.GetCurrentWalk()
    return EmoteMenu.CurrentWalk
end
exports('GetCurrentWalk', EmoteMenu.GetCurrentWalk)

---Set the players current walk style
---@param name string
function EmoteMenu.SetWalk(name)
    lib.requestAnimSet(name, 1000)
    SetPedMovementClipset(cache.ped, name, 0.2)
    RemoveAnimSet(name)
    SetResourceKvp('animations_walkstyle', name)
    EmoteMenu.CurrentWalk = name
end
exports('SetWalk', EmoteMenu.SetWalk)

---Reset the players walk style
function EmoteMenu.ResetWalk()
    ResetPedMovementClipset(cache.ped)
    SetResourceKvp('animations_walkstyle', 'default')
    EmoteMenu.CurrentWalk = 'default'
end
exports('ResetWalk', EmoteMenu.ResetWalk)

---Attach a prop to the player
---@param prop string
---@param bone number
---@param placement table
---@param variant number
---@return number object Entity handle
function EmoteMenu.AddPropToPlayer(prop, bone, placement, variant)
    local playerPos = GetEntityCoords(cache.ped)
    lib.requestModel(prop, 1000)
    local object = CreateObject(joaat(prop), playerPos.x, playerPos.y, playerPos.z + 0.2, true, true, true)
    if variant then SetObjectTextureVariation(object, variant) end
    AttachEntityToEntity(object, cache.ped, GetPedBoneIndex(cache.ped, bone), placement[1].x, placement[1].y, placement[1].z, placement[2].x, placement[2].y, placement[2].z, true, true, false, true, 1, true)
    EmoteMenu.PlayerProps[#EmoteMenu.PlayerProps + 1] = object
    SetModelAsNoLongerNeeded(prop)
    return object
end

---Remove unsupported emotes
function EmoteMenu.RemoveUnsupportedEmotes()
    local checkMenus = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }
    for i = 1, #checkMenus do
        AnimationList[checkMenus[i]] = EmoteMenu.RemoveFromTable(AnimationList[checkMenus[i]], function(_table, _index)
            return not (_table[_index].Build and (_table[_index].Build < EmoteMenu.GameBuild))
        end)
    end
end

---Search for animations
---@param query string
function EmoteMenu.Search(query)
    Wait(500)
    local checkMenus, foundEmotes = {
        'Walks',
        'Scenarios',
        'Expressions',
        'Emotes',
        'PropEmotes',
        'DanceEmotes',
        'SynchronizedEmotes',
        'AnimalEmotes'
    }, {}
    for i = 1, #checkMenus do
        local animType = checkMenus[i]
        local animList = AnimationList[animType]
        if animList then
            for emote = 1, #animList do
                local anim = animList[emote]
                if anim and (anim.Command and string.find(string.lower(anim.Command), query)) then
                    anim.CommandHandle = animType == 'Walks' and Config.WalkSetCommands[1] or Config.EmotePlayCommands[1]
                    anim.Type = animType
                    foundEmotes[#foundEmotes + 1] = anim
                end
            end
        end
    end
    if #foundEmotes < 1 then
        EmoteMenu.Notify('error', 'No animations found')
        lib.showMenu('animations_main_menu')
        return
    end
    local options = {}
    for emote = 1, #foundEmotes do
        local _emote = foundEmotes[emote]
        if _emote then
            options[#options + 1] = {label = _emote.Label, description = ('%s %s / (%s)'):format(_emote.CommandHandle, _emote.Command, _emote.Type), icon = 'fa-solid fa-person', args = _emote.Command, close = false}
        end
    end
    lib.registerMenu({
        id = 'animations_search_menu',
        title = 'Animation Menu',
        position = Config.MenuPosition,
        options = options,
        onClose = function(_)
            lib.showMenu('animations_main_menu')
        end,
    }, function(selected, scrollIndex, option)
        if EmoteMenu.isActionsLimited then return end
        local _type, emote = EmoteMenu.GetEmoteByCommand(option)
        if not _type then
            EmoteMenu.Notify('error', 'That isn\'t a valid emote or walk style')
            return
        end
        if _type == 'Walks' then
            EmoteMenu.SetWalk(emote.Walk)
        else
            EmoteMenu.Play(_type, emote)
        end
    end)
    lib.showMenu('animations_search_menu')
end

-- Add / Remove animations
EmoteMenu.RemoveUnsupportedEmotes()

if not Config.EnableNSFWEmotes then
    EmoteMenu.RemoveEmotes('NSFW')
end

if not Config.EnableSocialMovementEmotes then
    EmoteMenu.RemoveEmotes('SocialMovement')
end

EmoteMenu.AddEmotesToMenu('Emotes', Config.EmotePlayCommands[1])

EmoteMenu.AddEmotesToMenu('PropEmotes', Config.EmotePlayCommands[1])

EmoteMenu.AddEmotesToMenu('DanceEmotes', Config.EmotePlayCommands[1])

EmoteMenu.AddEmotesToMenu('Walks', Config.WalkSetCommands[1])

EmoteMenu.AddEmotesToMenu('Scenarios', Config.EmotePlayCommands[1])

EmoteMenu.AddEmotesToMenu('Expressions', Config.EmotePlayCommands[1])

if not Config.EnableSearch then
    mainMenuOptions = EmoteMenu.RemoveFromTable(mainMenuOptions, function(_table, _index)
        return _table[_index].args ~= 'animations_search'
    end)
end

if Config.EnableSynchronizedEmotes then
    EmoteMenu.AddEmotesToMenu('SynchronizedEmotes', Config.EmotePlayCommands[1])
else
    emoteMenuOptions = EmoteMenu.RemoveFromTable(emoteMenuOptions, function(_table, _index)
        return _table[_index].args ~= 'SynchronizedEmotes'
    end)
end

if Config.EnableAnimalEmotes then
    EmoteMenu.AddEmotesToMenu('AnimalEmotes', Config.EmotePlayCommands[1])
else
    emoteMenuOptions = EmoteMenu.RemoveFromTable(emoteMenuOptions, function(_table, _index)
        return _table[_index].args ~= 'AnimalEmotes'
    end)
end

-- Register Menus
--- Main Menu
lib.registerMenu({
    id = 'animations_main_menu',
    title = 'Animation Menu',
    position = Config.MenuPosition,
    options = mainMenuOptions,
}, function(selected, scrollIndex, option)
    if EmoteMenu.isActionsLimited then return end
    if option == 'animations_search' then
        local query = lib.inputDialog('Animation Search', {'Animation'})
        if not query then return end
        EmoteMenu.Search(string.lower(query[1]))
        return
    elseif option == 'animations_emote_menu' then
        lib.showMenu('animations_emote_menu')
        return
    elseif option == 'cancel' then
        if scrollIndex == 1 then
            EmoteMenu.CancelAnimation()
        elseif scrollIndex == 2 then
            EmoteMenu.ResetWalk()
        elseif scrollIndex == 3 then
            ClearFacialIdleAnimOverride(cache.ped)
        elseif scrollIndex == 4 then
            EmoteMenu.CancelAnimation()
            EmoteMenu.ResetWalk()
            ClearFacialIdleAnimOverride(cache.ped)
        end
        return
    end
    local emote = AnimationList[option][scrollIndex]
    if not emote then
        EmoteMenu.Notify('error', 'That isn\'t a valid option, please inform the server owner')
        return
    end
    if option == 'Walks' then
        EmoteMenu.SetWalk(emote.Walk)
        return
    end
    EmoteMenu.Play(option, emote)
end)

--- Emote Menu
lib.registerMenu({
    id = 'animations_emote_menu',
    title = 'Animation Menu',
    position = Config.MenuPosition,
    options = emoteMenuOptions,
    onClose = function(_)
        lib.showMenu('animations_main_menu')
    end,
}, function(selected, scrollIndex, option)
    if EmoteMenu.isActionsLimited then return end
    local emote = AnimationList[option][scrollIndex]
    if not emote then
        EmoteMenu.Notify('error', 'That isn\'t a valid emote')
        return
    end
    if option == 'SynchronizedEmotes' then
        EmoteMenu.RequestSynchronizedEmote(emote)
        return
    end
    EmoteMenu.Play(option, emote)
end)

-- Commands
for i = 1, #Config.MenuOpenCommands do
    RegisterCommand(Config.MenuOpenCommands[i], function(source, args, rawCommand)
        if EmoteMenu.isActionsLimited then return end
        EmoteMenu.OpenMenu()
    end)
end

for i = 1, #Config.EmotePlayCommands do
    RegisterCommand(Config.EmotePlayCommands[i], function(source, args, rawCommand)
        if EmoteMenu.isActionsLimited then return end
        if not args[1] then
            EmoteMenu.Notify('error', 'You need to provide a valid emote!')
            return
        end
        if args[1]:lower() == 'c' then
            EmoteMenu.CancelAnimation()
            return
        end
        local _type, emote = EmoteMenu.GetEmoteByCommand(args[1])
        if not _type or (_type == 'Walks') then
            EmoteMenu.Notify('error', 'That isn\'t a valid emote')
            return
        end
        local variant = nil
        if args[2] then
            local index = tonumber(args[2])
            if index then variant = index end
        end
        EmoteMenu.Play(_type, emote, variant)
    end)
end

for i = 1, #Config.WalkSetCommands do
    RegisterCommand(Config.WalkSetCommands[i], function(source, args, rawCommand)
        if EmoteMenu.isActionsLimited then return end
        if not args[1] then
            EmoteMenu.Notify('error', 'You need to provide a valid emote!')
            return
        end
        if args[1]:lower() == 'c' then
            EmoteMenu.ResetWalk()
            return
        end
        local _type, emote = EmoteMenu.GetEmoteByCommand(args[1])
        if not _type or (_type ~= 'Walks') then
            EmoteMenu.Notify('error', 'That isn\'t a valid walk style')
            return
        end
        EmoteMenu.SetWalk(emote.Walk)
    end)
end

-- Keybinds
if Config.MenuKeybind ~= '' then
    if #Config.MenuOpenCommands > 0 then
        RegisterKeyMapping(Config.MenuOpenCommands[1], 'Open the animation menu', 'keyboard', Config.MenuKeybind)
    end
end

if Config.CancelEmoteKey ~= '' then
    EmoteMenu.Keybinds.CancelKey = lib.addKeybind({
        name = 'ecancel',
        description = 'Cancel animation',
        defaultKey = Config.CancelEmoteKey,
        onPressed = function(key)
            EmoteMenu.CancelAnimation()
        end
    })
end

if Config.RagdollKeybind ~= '' then
    EmoteMenu.Keybinds.Ragdoll = lib.addKeybind({
        name = 'ragdoll',
        description = 'Ragdoll your character',
        defaultKey = Config.RagdollKeybind,
        onPressed = function(key)
            if EmoteMenu.isActionsLimited then return end
            EmoteMenu.IsRagdoll = not EmoteMenu.IsRagdoll
            while EmoteMenu.IsRagdoll do
                Wait(0)
                if IsPedOnFoot(cache.ped) then
                    SetPedToRagdoll(cache.ped, 1000, 1000, 0, 0, 0, 0)
                end
            end
        end
    })
end

if Config.HandsUpKey ~= '' then
    EmoteMenu.Keybinds.HandsUp = lib.addKeybind({
        name = 'handsup',
        description = 'Put your hands up',
        defaultKey = Config.HandsUpKey,
        onPressed = function(key)
            if EmoteMenu.isActionsLimited then return end
            lib.requestAnimDict('random@mugging3', 1000)
            TaskPlayAnim(cache.ped, 'random@mugging3', 'handsup_standing_base', 8.0, 8.0, -1, 50, 0, false, false, false)
        end,
        onReleased = function(key)
            ClearPedTasks(cache.ped)
        end
    })
end

if Config.CrouchKey ~= '' then
    EmoteMenu.Keybinds.Crouch = lib.addKeybind({
        name = 'crouch',
        description = 'Crouch',
        defaultKey = Config.CrouchKey,
        onPressed = function(key)
            if EmoteMenu.isActionsLimited or IsPedSittingInAnyVehicle(cache.ped) then return end
            EmoteMenu.IsCrouched = not EmoteMenu.IsCrouched
            if not EmoteMenu.IsCrouched then
                lib.requestAnimSet('move_ped_crouched', 1000)
                SetPedMovementClipset(cache.ped, 'move_ped_crouched', 0.2)
            else
                if EmoteMenu.CurrentWalk == 'default' then
                    ResetPedMovementClipset(cache.ped, 0.2)
                else
                    lib.requestAnimSet(EmoteMenu.CurrentWalk, 1000)
                    SetPedMovementClipset(cache.ped, EmoteMenu.CurrentWalk, 0.2)
                end
            end
        end
    })
end

if Config.PtfxKeybind then
    EmoteMenu.Keybinds.PlayPtfx = lib.addKeybind({
        name = 'playptfx',
        description = 'Play your selected particle effect',
        defaultKey = Config.PtfxKeybind,
        onPressed = function(key)
            LocalPlayer.state:set('ptfx', true, true)
            if not EmoteMenu.PtfxCanHold then
                LocalPlayer.state:set('ptfx', false, true)
            end
        end,
        onReleased = function(key)
            if EmoteMenu.PtfxCanHold then
                LocalPlayer.state:set('ptfx', false, true)
            end
        end
    })
end

-- State Bag Handlers
AddStateBagChangeHandler('ptfx', nil, function(bagName, key, value, _unused, replicated)
    local plyId = tonumber(bagName:gsub('player:', ''), 10)
    if (EmoteMenu.PlayerParticles[plyId] and value) or (not EmoteMenu.PlayerParticles[plyId] and not value) then return end
    local stateBag = Player(plyId).state
    if value then
        local asset, name, offset, rot, scale, propNet, entityTarget = stateBag.ptfxAsset, stateBag.ptfxName, stateBag.ptfxOffset, stateBag.ptfxRot, stateBag.ptfxScale or 1, stateBag.ptfxPropNet, cache.ped
        if propNet then
            local propObj = NetToObj(propNet)
            if DoesEntityExist(propObj) then
                entityTarget = propObj
            end
        end
        lib.requestNamedPtfxAsset(asset, 1000)
        UseParticleFxAssetNextCall(asset)
        EmoteMenu.PlayerParticles[plyId] = StartNetworkedParticleFxLoopedOnEntityBone(name, entityTarget, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, GetEntityBoneIndexByName(name, 'VFX'), scale + 0.0, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
        SetParticleFxLoopedColour(EmoteMenu.PlayerParticles[plyId], 1.0, 1.0, 1.0)
    else
        StopParticleFxLooped(EmoteMenu.PlayerParticles[plyId], false)
        RemoveNamedPtfxAsset(stateBag.ptfxAsset)
        EmoteMenu.PlayerParticles[plyId] = nil
    end
end)

-- Events
RegisterNetEvent('dpemotes:synchronizedEmoteRequest', function(sender, data, emote)
    PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET')
    EmoteMenu.ShowHelpAlert('fa-solid fa-question', ('[Y] - Accept, [N] - Deny: %s'):format(emote.Label))
    while true do
        Wait(0)
        if IsControlJustPressed(0, 246) then
            lib.hideTextUI()
            Citizen.InvokeNative(0x144da052257ae7d8, true)
            TriggerServerEvent('dpemotes:synchronizedEmoteResponse', sender, data, emote)
            break  
        elseif IsControlJustPressed(0, 182) then
            lib.hideTextUI()
            break    
        end
    end
end)

RegisterNetEvent('dpemotes:startSynchronizedEmote', function(target, data, other)
    local playerPos = GetEntityCoords(cache.ped)
    local targetId, targetPed, targetPos = lib.getClosestPlayer(playerPos, 5.0, false)
    if not targetId then
        EmoteMenu.Notify('error', 'No player nearby!')
        TriggerServerEvent('dpemotes:cancelSynchronizedEmote', target)
        return
    end

    if targetId ~= GetPlayerFromServerId(target) then
        EmoteMenu.Notify('error', 'The player is no longer closest to you!')
        TriggerServerEvent('dpemotes:cancelSynchronizedEmote', target)
        return
    end

    local isOneValid, isTwoValid = lib.requestAnimDict(data.Dictionary, 1000), lib.requestAnimDict(other.Dictionary, 1000)
    if not isOneValid or not isTwoValid then
        EmoteMenu.Notify('error', 'That isn\'t a valid emote')
        return
    end

    Citizen.InvokeNative(0x144da052257ae7d8, true)
    local targetOffset = GetOffsetFromEntityInWorldCoords(targetPed, data.Options.Offset.x, data.Options.Offset.y, data.Options.Offset.z)
    local synchronized_scene = NetworkCreateSynchronisedScene(targetOffset.x, targetOffset.y, targetOffset.z, 0.0, 0.0, GetEntityHeading(targetPed), 2, false, false, 1.0, -1, 1.0)
    NetworkAddPedToSynchronisedScene(cache.ped, synchronized_scene, data.Dictionary, data.Animation, 1.5, -4.0, 1, 16, 0, 0)
    NetworkAddPedToSynchronisedScene(targetPed, synchronized_scene, other.Dictionary, other.Animation, 1.5, -4.0, 1, 16, 0, 0)

    NetworkStartSynchronisedScene(synchronized_scene)
    Wait(GetAnimDuration(data.Dictionary, data.Animation) * 1000)
    NetworkStopSynchronisedScene(synchronized_scene)
end)

RegisterNetEvent('dpemotes:cancelSynchronizedEmote', function()
    Citizen.InvokeNative(0x144da052257ae7d8, false)
    EmoteMenu.Notify('error', 'The emote was cancelled!')
end)

-- Cache
lib.onCache('ped', function(playerPed)
    if cache.ped ~= playerPed then
        if EmoteMenu.CurrentWalk ~= 'default' then
            EmoteMenu.SetWalk(EmoteMenu.CurrentWalk)
        end
    end
end)

AddEventHandler('playerSpawned', function()
    Wait(1000)
    if EmoteMenu.CurrentWalk ~= 'default' then
        EmoteMenu.SetWalk(EmoteMenu.CurrentWalk)
    end
end)

AddEventHandler('entityDamaged', function(entity)
    if cache.ped == entity then
        if not IsPedFatallyInjured(EmoteMenu.PlayerId, 1) then return end 
        EmoteMenu.RemoveProps()
        ClearPedTasksImmediately(cache.ped)
        DetachEntity(cache.ped, true, false)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        EmoteMenu.RemoveProps()
        ClearPedTasksImmediately(cache.ped)
        DetachEntity(cache.ped, true, false)
        ResetPedMovementClipset(cache.ped)
    end
end)
