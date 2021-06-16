Config = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
	if length > 0 then
		return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

Config.RandomInt = function(length)
	if length > 0 then
		return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["schotten"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.Locations = {
   ["duty"] = {
       [1] = {x = 13.88, y = -1106.34, z = 29.8, h = 160.64},
   },    
   ["vehicle"] = {
   },    
   ["stash"] = {
       [1] = {x = 19.3, y = -1103.8, z = 29.8, h = 337.92},
       [2] = {x = 24.0, y = -1107.55, z = 29.8, h = 156.06},

   },     
   ["impound"] = {

   }, 
   ["helicopter"] = {

   }, 
   ["armory"] = {

   },   
   ["trash"] = {

   },      
   ["fingerprint"] = {

   },
   ["evidence"] = {

   },    
   ["evidence2"] = {

   },   
   ["evidence3"] = {

   },        
   ["stations"] = {
       [1] = {label = "CS-ARMOR", coords = {x = 18.97, y = -1112.31, z = 42.37, h = 3.5}},

   },
}

Config.ArmoryWhitelist = {
    "FUN28030",
    "HHV33808",
    "MWE31087",
    "UOH84809",
    "ONT04484",
    "SUC74168",
    "KGV59544",
    "OEJ87427",
}

Config.Helicopter = "pzulu"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
    },
}

Config.Vehicles = {
    ["ptouran"] = "Volkswagen Touran",
}

Config.WhitelistedVehicles = {
    ["pcharger"] = "Dodge Charger (UC)",
}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm Parabellum kogel",
}

Config.Radars = {
	{x = -623.44421386719, y = -823.08361816406, z = 25.25704574585, h = 145.0 },
	{x = -652.44421386719, y = -854.08361816406, z = 24.55704574585, h = 325.0 },
	{x = 1623.0114746094, y = 1068.9924316406, z = 80.903594970703, h = 84.0 },
	{x = -2604.8994140625, y = 2996.3391113281, z = 27.528566360474, h = 175.0 },
	{x = 2136.65234375, y = -591.81469726563, z = 94.272926330566, h = 318.0 },
	{x = 2117.5764160156, y = -558.51013183594, z = 95.683128356934, h = 158.0 },
	{x = 406.89505004883, y = -969.06286621094, z = 29.436267852783, h = 33.0 },
	{x = 657.315, y = -218.819, z = 44.06, h = 320.0 },
	{x = 2118.287, y = 6040.027, z = 50.928, h = 172.0 },
	{x = -106.304, y = -1127.5530, z = 30.778, h = 230.0 },
	{x = -823.3688, y = -1146.980, z = 8.0, h = 300.0 },
}

Config.CarItems = {
    [1] = {
        name = "heavyarmor",
        amount = 2,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "empty_evidence_bag",
        amount = 10,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "armor_stormram",
        amount = 1,
        info = {},
        type = "item",
        slot = 3,
    },
}

Config.Items = {
    label = "Tienda",
    slots = 30,
    items = {
        [1] = {
            name = "water_bottle",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "kurkakola",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "beer",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "coffee",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "kurkakola",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "tosti",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "twerks_candy",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "snikkel_candy",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "sandwich",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "phone",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "snikkel_candy",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 11,
        },
        [12] = {
            name = "boombox",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 12,
        },
        -- [13] = {
        --     name = "cocacola",
        --     price = 0,
        --     amount = 1,
        --     info = {},
        --     type = "item",
        --     slot = 13,
        -- },
        -- [14] = {
        --     name = "redbull",
        --     price = 0,
        --     amount = 1,
        --     info = {},
        --     type = "item",
        --     slot = 14,
        -- },
        -- [15] = {
        --     name = "powerade",
        --     price = 0,
        --     amount = 1,
        --     info = {},
        --     type = "item",
        --     slot = 15,
        -- },
        -- [14] = {
        --     name = "nestea",
        --     price = 0,
        --     amount = 1,
        --     info = {},
        --     type = "item",
        --     slot = 14,
        -- [16] = {
        --     name = "chucherias",
        --     price = 0,
        --     amount = 1,
        --     info = {},
        --     type = "item",
        --     slot = 16,
        -- },
        -- [17] = {
        --     name = "galletasmaria",
        --     price = 0,
        --     amount = 1,
        --     info = {},
        --     type = "item",
        --     slot = 17,
        -- },

        -- },
        -- [19] = {
        --     name = "gofre",
        --     price = 0,
        --     amount = 1,
        --     info = {},
        --     type = "item",
        --     slot = 19,
        -- },
    }
}

