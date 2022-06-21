resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
fx_version 'adamant'
game 'gta5'

server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/main.lua',
}

client_scripts{
    '@es_extended/locale.lua',
    'client/main.lua',
}