_G.DedicatedServer = _G.DedicatedServer or {}

DedicatedServer.ModPath = ModPath
DedicatedServer.options_menu = "DedicatedServer_menu"
DedicatedServer.Settings = {}
DedicatedServer.Last_Data = {}

Hooks:Add("LocalizationManagerPostInit", "DedicatedServer_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["DedicatedServer_menu_title"] = "Dedicated Server",
		["DedicatedServer_menu_desc"] = " ",
		["DedicatedServer_menu_Reset_title"] = "Reset",
	})
end)

Hooks:Add("MenuManagerSetupCustomMenus", "DedicatedServerOptions", function(menu_manager, nodes)
	MenuHelper:NewMenu(DedicatedServer.options_menu)
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "DedicatedServerOptions", function(menu_manager, nodes)
	MenuCallbackHandler.DedicatedServer_menu_Reset_callback = function(self, item)
		DedicatedServer:Reset_Settings()
		DedicatedServer:Reset_Last_Data()
		local _dialog_data = {
			title = "Dedicated Server",
			text = "Reset all to default",
			button_list = {{ text = "[OK]", is_cancel_button = true }},
			id = tostring(math.random(0,0xFFFFFFFF))
		}
		managers.system_menu:show(_dialog_data)
	end
	MenuHelper:AddButton({
		id = "DedicatedServer_menu_Reset_callback",
		title = "DedicatedServer_menu_Reset_title",
		callback = "DedicatedServer_menu_Reset_callback",
		menu_id = DedicatedServer.options_menu,
	})
end)

Hooks:Add("MenuManagerBuildCustomMenus", "DedicatedServerOptions", function(menu_manager, nodes)
	nodes[DedicatedServer.options_menu] = MenuHelper:BuildMenu(DedicatedServer.options_menu)
	MenuHelper:AddMenuItem(MenuHelper.menus.lua_mod_options_menu, DedicatedServer.options_menu, "DedicatedServer_menu_title", "DedicatedServer_menu_desc")
end)

function DedicatedServer:Save_Settings()
	local _file = io.open(self.ModPath .. "/cfg/Settings.txt", "w+")
	if _file then
		_file:write(json.encode(self.Settings))
		io.close(_file)
	end
end

function DedicatedServer:Save_Last_Data()
	local _file = io.open(self.ModPath .. "/tmp/Last_Data.txt", "w+")
	if _file then
		_file:write(json.encode(self.Last_Data))
		io.close(_file)
	end
end

function DedicatedServer:Load_Last_Datat()
	local _file = io.open(self.ModPath .. "/tmp/Last_Data.txt", "r")
	if _file then
		self.Last_Data = json.decode(_file:read("*all"))
		io.close(_file)
	else
		self:Reset_Last_Data()
	end
end

function DedicatedServer:Load_Settings()
	local _file = io.open(self.ModPath .. "/cfg/Settings.txt", "r")
	if _file then
		self.Settings = json.decode(_file:read("*all"))
		io.close(_file)
	else
		self:Reset_Settings()
	end
end

function DedicatedServer:Reset_Last_Data()
	self.Last_Data = {
		Last_Lobby_Hesitcycle = 1,
	}
	self:Save_Last_Data()
end

function DedicatedServer:Reset_Settings()
	self.Settings = {
		["Lobby_Name"] = "Auto-Lobby by Dr_Newbie",
		["Lobby_Announce_When_Someone_Join"] = {
			"Welcome to this lobby, this lobby host by BOT",
			"This bot will auto open lobby and start the game",
			"If bot stuck, it means someone isn't ready or loaded",
		},
		["Lobby_Min_Amount_To_Start"] = 1,
		["Lobby_Time_To_Start_Game"] = 36,
		["Lobby_Do_Countdown_Before_Start_Game"] = 4,
		["Lobby_Default_Setting"] = {
			["job"] = "jewelry_store",
			["difficulty"] = "overkill_145",
			["permission"] = "public",
			["min_rep"] = 0,
			["drop_in"] = true,
			["kicking_allowed"] = true,
			["team_ai"] = true,
			["auto_kick"] = true
		},
		["Lobby_Hesitcycle"] = {
			{ ["difficulty"] = "overkill_145", ["job"] = "mia" },
			{ ["difficulty"] = "overkill_145", ["job"] = "hox" },
		},
		["Game_Send_HostBOT_To_Jail"] = true,
		["Game_HostBOT_Donnot_Release"] = true,
		["Game_Cancel_Hesit_Casue_Wait_Too_Long"] = 60,
	}
	self:Save_Settings()
end

DedicatedServer:Load_Last_Datat()

DedicatedServer:Load_Settings()