_G.DedicatedServer = _G.DedicatedServer or {}
local Lobby_Min_Amount_To_Start = DedicatedServer.Settings.Lobby_Min_Amount_To_Start or 0
local DedicatedServer_MissionBriefingGui_update = MissionBriefingGui.update
function MissionBriefingGui:update(t, dt)
	DedicatedServer_MissionBriefingGui_update(self, t, dt)
	if t > 7 and not self._ready then
		self:on_ready_pressed()
	end
	if Lobby_Min_Amount_To_Start > 0 and t > Lobby_Min_Amount_To_Start and game_state_machine:current_state_name() ~= "disconnected" then
		MenuCallbackHandler:load_start_menu_lobby()
	end
end