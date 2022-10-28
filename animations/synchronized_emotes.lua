AnimationList.SynchronizedEmotes = {
    {
        Label = 'Baseball',
        Command = 'baseball',
        Animation = 'baseball_a_player_a',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            Synchronized = {
                OtherAnimation = 'baseballthrow',
            },
        },
    },
    {
        Label = 'Baseball Throw',
        Command = 'baseballthrow',
        Animation = 'baseball_a_player_b',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            Synchronized = {
                OtherAnimation = 'baseball',
            },
        },
    },
    {
        Label = 'Bro',
        Command = 'bro',
        Animation = 'hugs_guy_a',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Synchronized = {
                FrontOffset = 1.14,
                OtherAnimation = 'bro2',
            },
        },
    },
    {
        Label = 'Bro 2',
        Command = 'bro2',
        Animation = 'hugs_guy_b',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Synchronized = {
                FrontOffset = 1.14,
                OtherAnimation = 'bro',
            },
        },
    },
    {
        Label = 'Carry',
        Command = 'carry',
        Animation = 'fin_c2_mcs_1_camman',
        Dictionary = 'missfinale_c2mcs_1',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'carry2',
            },
        },
    },
    {
        Label = 'Be carried',
        Command = 'carry2',
        Animation = 'firemans_carry',
        Dictionary = 'nm',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                Attach = true,
                Bone = 40269,
                OtherAnimation = 'carry',
                Placement = {
                    vector3(-0.140000, 0.150000, 0.140000),
                    vector3(0.000000, -59.000000, -4.500000),
                },
            },
        },
    },
    {
        Label = 'Carry 2',
        Command = 'carry3',
        Animation = 'idle',
        Dictionary = 'anim@heists@box_carry@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'carry4',
            },
        },
    },
    {
        Label = 'Be carried 2',
        Command = 'carry4',
        Animation = 'base',
        Dictionary = 'amb@code_human_in_car_idles@generic@ps@base',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                Attach = true,
                Bone = 28252,
                OtherAnimation = 'carry3',
                Placement = {
                    vector3(0.350000, 0.150000, -0.150000),
                    vector3(-42.500000, -22.500000, 22.500000),
                },
            },
        },
    },
    {
        Label = 'Carry Big Dog',
        Command = 'cbdog',
        Animation = 'idle',
        Dictionary = 'anim@heists@box_carry@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'cbdog2',
            },
        },
    },
    {
        Label = 'Big Dog Carried',
        Command = 'cbdog2',
        Animation = 'sleep_in_kennel',
        Dictionary = 'creatures@rottweiler@amb@sleep_in_kennel@',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                Attach = true,
                OtherAnimation = 'cbdog',
                Placement = {
                    vector3(-0.100000, 0.650000, 0.430000),
                    vector3(0.000000, 0.000000, -100.000000),
                },
            },
        },
    },
    {
        Label = 'Couple Drinking (Wine Glasses)',
        Command = 'coupleanim',
        Animation = 'action_var_01_bank_manager',
        Dictionary = 'anim@scripted@robbery@tun_prep_uni_ig1_couple@',
        Options = {
            Flags = {
                Loop = true,
            },
            Props = {
                {
                    Bone = 60309,
                    Name = 'p_wine_glass_s',
                    Placement = {
                        vector3(-0.050000, -0.010000, -0.170000),
                        vector3(0.000000, 0.000000, 0.000000),
                    },
                },
            },
            Synchronized = {
                OtherAnimation = 'coupleanim2',
            },
        },
        Build = 2372
    },
    {
        Label = 'Couple Drinking F (Wine Glasses)',
        Command = 'coupleanim2',
        Animation = 'action_var_01_female',
        Dictionary = 'anim@scripted@robbery@tun_prep_uni_ig1_couple@',
        Options = {
            Flags = {
                Loop = true,
            },
            Props = {
                {
                    Bone = 28422,
                    Name = 'p_wine_glass_s',
                    Placement = {
                        vector3(0.000000, 0.000000, 0.000000),
                        vector3(0.000000, 0.000000, 0.000000),
                    },
                },
            },
            Synchronized = {
                FrontOffset = 0.11,
                OtherAnimation = 'coupleanim',
                SideOffset = -0.04125,
            },
        },
        Build = 2372
    },
    {
        Label = 'Give CPR',
        Command = 'cprs',
        Animation = 'cpr_pumpchest',
        Dictionary = 'mini@cpr@char_a@cpr_str',
        Options = {
            Delay = 250,
            Flags = {
                Loop = true,
            },
            Synchronized = {
                OtherAnimation = 'cprs2',
            },
        },
    },
    {
        Label = 'Get CPR',
        Command = 'cprs2',
        Animation = 'cpr_pumpchest',
        Dictionary = 'mini@cpr@char_b@cpr_str',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                Attach = true,
                OtherAnimation = 'cprs',
                Placement = {
                    vector3(0.350000, 0.800000, 0.000000),
                    vector3(0.000000, 0.000000, 270.000000),
                },
            },
        },
    },
    {
        Label = 'Give CPR 2',
        Command = 'cprs3',
        Animation = 'cpr_loop_paramedic',
        Dictionary = 'missheistfbi3b_ig8_2',
        Options = {
            Delay = 250,
            Flags = {
                Loop = true,
            },
            Synchronized = {
                OtherAnimation = 'cprs4',
            },
        },
    },
    {
        Label = 'Get CPR 2',
        Command = 'cprs4',
        Animation = 'cpr_loop_victim',
        Dictionary = 'missheistfbi3b_ig8_2',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                Attach = true,
                OtherAnimation = 'cprs3',
                Placement = {
                    vector3(0.350000, 0.650000, 0.000000),
                    vector3(0.000000, 0.000000, 270.000000),
                },
            },
        },
    },
    {
        Label = 'Give',
        Command = 'give',
        Animation = 'givetake1_a',
        Dictionary = 'mp_common',
        Options = {
            Duration = 2000,
            Flags = {
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'give2',
            },
        },
    },
    {
        Label = 'Give 2',
        Command = 'give2',
        Animation = 'givetake1_b',
        Dictionary = 'mp_common',
        Options = {
            Duration = 2000,
            Flags = {
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'give',
            },
        },
    },
    {
        Label = 'Give Blowjob',
        Command = 'giveblowjob',
        Animation = 'pimpsex_hooker',
        Dictionary = 'misscarsteal2pimpsex',
        Options = {
            Duration = 30000,
            Synchronized = {
                FrontOffset = 0.63,
                OtherAnimation = 'receiveblowjob',
            },
        },
        NSFW = true,
    },
    {
        Label = 'Handshake',
        Command = 'handshake',
        Animation = 'handshake_guy_a',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Duration = 3000,
            Flags = {
                Move = true,
            },
            Synchronized = {
                FrontOffset = 0.9,
                OtherAnimation = 'handshake2',
            },
        },
    },
    {
        Label = 'Handshake 2',
        Command = 'handshake2',
        Animation = 'handshake_guy_b',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Duration = 3000,
            Flags = {
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'handshake',
            },
        },
    },
    {
        Label = 'Headbutt',
        Command = 'headbutt',
        Animation = 'plyr_takedown_front_headbutt',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Synchronized = {
                OtherAnimation = 'headbutted',
            },
        },
    },
    {
        Label = 'Headbutted',
        Command = 'headbutted',
        Animation = 'victim_takedown_front_headbutt',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Synchronized = {
                OtherAnimation = 'headbutt',
            },
        },
    },
    {
        Label = 'Take hostage',
        Command = 'hostage',
        Animation = 'perp_idle',
        Dictionary = 'anim@gangops@hostage@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'hostage2',
            },
        },
    },
    {
        Label = 'Be hostage',
        Command = 'hostage2',
        Animation = 'victim_idle',
        Dictionary = 'anim@gangops@hostage@',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                Attach = true,
                OtherAnimation = 'hostage',
                Placement = {
                    vector3(-0.300000, 0.100000, 0.000000),
                    vector3(0.000000, 0.000000, 0.000000),
                },
            },
        },
    },
    {
        Label = 'Hug',
        Command = 'hug',
        Animation = 'kisses_guy_a',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Duration = 5000,
            Synchronized = {
                FrontOffset = 1.05,
                OtherAnimation = 'hug2',
            },
        },
    },
    {
        Label = 'Hug 2',
        Command = 'hug2',
        Animation = 'kisses_guy_b',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Duration = 5000,
            Synchronized = {
                FrontOffset = 1.18,
                OtherAnimation = 'hug',
            },
        },
    },
    {
        Label = 'Hug Romantic 1',
        Command = 'hug3',
        Animation = 'chad_armsaround_chad',
        Dictionary = 'misscarsteal2chad_goodbye',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                FrontOffset = 0.52,
                OtherAnimation = 'hug4',
                SideOffset = -0.05,
            },
        },
    },
    {
        Label = 'Hug Romantic 2',
        Command = 'hug4',
        Animation = 'chad_armsaround_girl',
        Dictionary = 'misscarsteal2chad_goodbye',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                FrontOffset = 0.52,
                OtherAnimation = 'hug3',
                SideOffset = -0.05,
            },
        },
    },
    {
        Label = 'Kiss',
        Command = 'kiss',
        Animation = 'cs_lestercrest_3_dual-20',
        Dictionary = 'hs3_ext-20',
        Options = {
            Duration = 10000,
            Synchronized = {
                FrontOffset = 0.08,
                OtherAnimation = 'kiss2',
            },
        },
        Build = 2060
    },
    {
        Label = 'Kiss 2',
        Command = 'kiss2',
        Animation = 'csb_georginacheng_dual-20',
        Dictionary = 'hs3_ext-20',
        Options = {
            Duration = 10000,
            Synchronized = {
                FrontOffset = 0.08,
                OtherAnimation = 'kiss',
            },
        },
        Build = 2060
    },
    {
        Label = 'Kiss 3',
        Command = 'kiss3',
        Animation = 'cs_lestercrest_3_dual-19',
        Dictionary = 'hs3_ext-19',
        Options = {
            Duration = 10000,
            Synchronized = {
                FrontOffset = 0.08,
                OtherAnimation = 'kiss4',
            },
        },
        Build = 2060
    },
    {
        Label = 'Kiss 4',
        Command = 'kiss4',
        Animation = 'csb_georginacheng_dual-19',
        Dictionary = 'hs3_ext-19',
        Options = {
            Duration = 10000,
            Synchronized = {
                FrontOffset = 0.08,
                OtherAnimation = 'kiss3',
            },
        },
        Build = 2060
    },
    {
        Label = 'Offer Piggy Back',
        Command = 'pback',
        Animation = 'piggyback_c_player_a',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'pback2',
            },
        },
    },
    {
        Label = 'Be Piggy Backed',
        Command = 'pback2',
        Animation = 'piggyback_c_player_b',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                Attach = true,
                Bone = 0,
                OtherAnimation = 'pback',
                Placement = {
                    vector3(0.000000, -0.070000, 0.400000),
                    vector3(0.000000, 0.000000, 0.000000),
                },
            },
        },
    },
    {
        Label = 'Punch',
        Command = 'punch',
        Animation = 'plyr_takedown_rear_lefthook',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Synchronized = {
                OtherAnimation = 'punched',
            },
        },
    },
    {
        Label = 'Punched',
        Command = 'punched',
        Animation = 'victim_takedown_front_cross_r',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Synchronized = {
                OtherAnimation = 'punch',
            },
        },
    },
    {
        Label = 'Receive Blowjob',
        Command = 'receiveblowjob',
        Animation = 'pimpsex_punter',
        Dictionary = 'misscarsteal2pimpsex',
        Options = {
            Duration = 30000,
            Synchronized = {
                FrontOffset = 0.63,
                OtherAnimation = 'giveblowjob',
            },
        },
        NSFW = true,
    },
    {
        Label = 'Search',
        Command = 'search',
        Animation = 'police',
        Dictionary = 'custom@police',
        Options = {
            Flags = {
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'search2',
            },
        },
    },
    {
        Label = 'Be searched',
        Command = 'search2',
        Animation = 'a2_pose',
        Dictionary = 'missfam5_yoga',
        Options = {
            Flags = {
                Move = true,
            },
            Synchronized = {
                Attach = true,
                OtherAnimation = 'search',
                Placement = {
                    vector3(0.000000, 0.500000, 0.000000),
                    vector3(0.000000, 0.000000, 0.000000),
                },
            },
        },
    },
    {
        Label = 'Slap',
        Command = 'slap',
        Animation = 'plyr_takedown_front_slap',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Duration = 2000,
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'slapped',
            },
        },
    },
    {
        Label = 'Slap 2',
        Command = 'slap2',
        Animation = 'plyr_takedown_front_backslap',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Duration = 2000,
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'slapped2',
            },
        },
    },
    {
        Label = 'Slapped',
        Command = 'slapped',
        Animation = 'victim_takedown_front_slap',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Synchronized = {
                OtherAnimation = 'slapped2',
            },
        },
    },
    {
        Label = 'Slapped 2',
        Command = 'slapped2',
        Animation = 'victim_takedown_front_backslap',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Synchronized = {
                OtherAnimation = 'slapped',
            },
        },
    },
    {
        Label = 'Stick Up',
        Command = 'stickup',
        Animation = 'biker_02_stickup_loop',
        Dictionary = 'random@countryside_gang_fight',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'stickupscared',
            },
        },
    },
    {
        Label = 'Stickup Scared',
        Command = 'stickupscared',
        Animation = 'handsup_base',
        Dictionary = 'missminuteman_1ig_2',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Synchronized = {
                OtherAnimation = 'stickup',
            },
        },
    },
    {
        Label = 'Street Sex Female',
        Command = 'streetsexfemale',
        Animation = 'shagloop_hooker',
        Dictionary = 'misscarsteal2pimpsex',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                FrontOffset = 0.5,
                OtherAnimation = 'streetsexmale',
            },
        },
        NSFW = true,
    },
    {
        Label = 'Street Sex Male',
        Command = 'streetsexmale',
        Animation = 'shagloop_pimp',
        Dictionary = 'misscarsteal2pimpsex',
        Options = {
            Flags = {
                Loop = true,
            },
            Synchronized = {
                FrontOffset = 0.5,
                OtherAnimation = 'streetsexfemale',
            },
        },
        NSFW = true,
    }
}

