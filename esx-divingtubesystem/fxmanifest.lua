fx_version 'cerulean'
game 'gta5'
description 'Esx-Diving'
version '1.1.0'
shared_script {
    '@es_extended/locale.lua',
    'locales/*',
}
server_script 'server/main.lua'
client_scripts {
    'client/main.lua'
}
lua54 'yes'
