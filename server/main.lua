RegisterNetEvent('dpemotes:requestSynchronizedEmote', function(target, data, emote)
    local src = source
    TriggerClientEvent('dpemotes:synchronizedEmoteRequest', target, src, data, emote)
end)

RegisterNetEvent('dpemotes:synchronizedEmoteResponse', function(sender, data, emote)
    local src = source
    TriggerClientEvent('dpemotes:startSynchronizedEmoteOnSource', sender, src, data)
    TriggerClientEvent('dpemotes:startSynchronizedEmoteOnTarget', src, sender, emote, data)
end)

RegisterNetEvent('dpemotes:cancelSynchronizedEmote', function(target)
    TriggerClientEvent('dpemotes:cancelSynchronizedEmote', target)
end)

RegisterNetEvent('dpemotes:syncPtfx', function(asset, name, offset, rot, scale)
    if type(asset) ~= 'string' or type(name) ~= 'string' or type(offset) ~= 'vector3' or type(rot) ~= 'vector3' then return end
    local srcPlayerState = Player(source).state
    srcPlayerState:set('ptfxAsset', asset, true)
    srcPlayerState:set('ptfxName', name, true)
    srcPlayerState:set('ptfxOffset', offset, true)
    srcPlayerState:set('ptfxRot', rot, true)
    srcPlayerState:set('ptfxScale', scale, true)
    srcPlayerState:set('ptfxPropNet', false, true)
    srcPlayerState:set('ptfx', false, true)
end)

RegisterNetEvent('dpemotes:syncProp', function(propNet)
    local srcPlayerState = Player(source).state
    if propNet then
        local waitForEntityToExistCount = 0
        while waitForEntityToExistCount <= 100 and not DoesEntityExist(NetworkGetEntityFromNetworkId(propNet)) do
            Wait(10)
            waitForEntityToExistCount = waitForEntityToExistCount + 1
        end
        if waitForEntityToExistCount < 100 then
            srcPlayerState:set('ptfxPropNet', propNet, true)
            return
        end
    end
    srcPlayerState:set('ptfxPropNet', false, true)
end)

-- Version check
local function VersionLog(_type, log)
    local color = _type == 'success' and '^2' or '^1'
    print(('^5[dpemotes]%s %s^7'):format(color, log))
end

local function CheckMenuVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/scullyy/dpemotes/master/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
        if not text then 
            VersionLog('error', 'Currently unable to run a version check.')
            return 
        end
        VersionLog('success', ('Current Version: %s'):format(currentVersion))
        VersionLog('success', ('Latest Version: %s'):format(text))
        if text == currentVersion then
            VersionLog('success', 'You are running the latest version.')
        else
            VersionLog('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end
CheckMenuVersion()