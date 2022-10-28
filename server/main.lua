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