fx_version 'cerulean'
game 'gta5'
author 'Cs0ng0r'
description 'Safe Robbery Script'
lua54 'yes'

shared_scripts {
    'shared/*.lua',
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

files {
    'locales/*.json'
}

escrow_ignore 'locales/*.json'
escrow_ignore 'shared/*.lua'
escrow_ignore 'server/logs.lua'
