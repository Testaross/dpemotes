AnimationList.SynchronizedEmotes = {
    {
        Label = 'Baseball',
        Command = 'baseball',
        Animation = 'baseball_a_player_a',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            OtherAnimation = 'baseballthrow',
            Offset = vector3(0.0, 0.0, -1.0)
        },
    },
    {
        Label = 'Baseball Throw',
        Command = 'baseballthrow',
        Animation = 'baseball_a_player_b',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            OtherAnimation = 'baseball',
            Offset = vector3(0.0, 0.0, -1.0)
        },
    },
    {
        Label = 'Cuff',
        Command = 'cuff',
        Animation = 'arrest_on_floor_back_left_a',
        Dictionary = 'mp_arresting',
        Options = {
            OtherAnimation = 'getcuffed',
            Offset = vector3(0.0, 0.0, 0.0)
        },
    },
    {
        Label = 'Get Cuffed',
        Command = 'getcuffed',
        Animation = 'arrest_on_floor_back_left_b',
        Dictionary = 'mp_arresting',
        Options = {
            OtherAnimation = 'cuff',
            Offset = vector3(0.0, 0.0, 0.0)
        },
    },
}

