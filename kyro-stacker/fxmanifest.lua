fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kyro'
description 'Stacker Game'
version '1.0.0'

-- Client-side script
client_script 'client.lua'
server_script {
    'server.lua',
"@mysql-async/lib/MySQL.lua",
'@ox_lib/init.lua',}

-- NUI files
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/client.js',
    'html/style.css'
}
shared_scripts {
    '@ox_lib/init.lua',
}