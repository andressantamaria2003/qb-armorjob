fx_version 'cerulean'
game 'gta5'

description 'QB-armorJob'
version '1.0.0'

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/interactions.lua',
	'client/job.lua',
	'client/gui.lua',
	-- 'client/heli.lua',
	--'client/anpr.lua',
	-- 'client/evidence.lua',
}

server_scripts {
	'config.lua',
	'server/main.lua',
}

ui_page "html/index.html"

files {
    "html/index.html",
    "html/vue.min.js",
	"html/script.js",
	"html/tablet-frame.png",
	"html/fingerprint.png",
	"html/main.css",
	"html/vcr-ocd.ttf",
}

exports {
	'IsHandcuffed',
	'IsArmoryWhitelist'
}

dependencies {
	'qb-core'
}