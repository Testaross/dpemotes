--- Check for updates at https://github.com/Scullyy/dpemotes ---
fx_version 'adamant'

game 'gta5'
version '3.3.1'

dependencies {
    '/server:5848',
    '/onesync'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts {
    'server/*.lua'
}

client_scripts {
    'animations/emotes.lua',
    'animations/prop_emotes.lua',
    'animations/dance_emotes.lua',
    'animations/animal_emotes.lua',
    'animations/synchronized_emotes.lua',
    'animations/walks.lua',
    'animations/scenarios.lua',
    'animations/expressions.lua',
    'animations.lua',
    'client/*.lua'
}

data_file 'DLC_ITYP_REQUEST' 'bzzz_foodpack.ytyp'
data_file 'DLC_ITYP_REQUEST' 'bzzz_prop_torch_fire001.ytyp'
data_file 'DLC_ITYP_REQUEST' 'natty_props_lollipops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'dpemotes.ytyp'
data_file 'DLC_ITYP_REQUEST' 'badges.ytyp'
data_file 'DLC_ITYP_REQUEST' 'lilflags_ytyp.ytyp'
data_file 'DLC_ITYP_REQUEST' 'prideprops_ytyp.ytyp'

lua54 'yes'

