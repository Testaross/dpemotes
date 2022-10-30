-- Place any of your custom animations in here and keep a backup of this file for future updates.
local custom = {
    Walks = {},
    Scenarios = {},
    Expressions = {},
    Emotes = {},
    PropEmotes = {},
    DanceEmotes = {},
    SynchronizedEmotes = {},
    AnimalEmotes = {}
}

for _type, emote in pairs(custom) do
    AnimationList[_type][#AnimationList[_type] + 1] = emote
end