_G.DedicatedServer = _G.DedicatedServer or {}
local _MissionBriefingGui_update_announce = {}
local DedicatedServer_MissionBriefingGui_update = MissionBriefingGui.update
function MissionBriefingGui:update(t, dt)
	DedicatedServer_MissionBriefingGui_update(self, t, dt)
	local Game_Cancel_Hesit_Casue_Wait_Too_Long = DedicatedServer and DedicatedServer.Settings and DedicatedServer.Settings.Game_Cancel_Hesit_Casue_Wait_Too_Long or 60
	local _Msg = DedicatedServer and DedicatedServer.Settings and DedicatedServer.Settings.Game_Announce_When_Ready_To_Start or {}
	local tickkk = math.round(t) - 1
	local _Msg_Amount = _Msg and #_Msg or 0
	if _Msg_Amount > 0 and  tickkk >= 1 and tickkk <= _Msg_Amount and not _MissionBriefingGui_update_announce[tickkk] and _Msg[tickkk] then
		_MissionBriefingGui_update_announce[tickkk] = true
		if managers.chat then
			managers.chat:send_message(ChatManager.GAME, "[Auto-Looby]", _Msg[tickkk])
		end
	end
	if t > 7+_Msg_Amount and not self._ready then
		self:on_ready_pressed()
	end
	if Game_Cancel_Hesit_Casue_Wait_Too_Long >= 0 and t > Game_Cancel_Hesit_Casue_Wait_Too_Long and game_state_machine:current_state_name() ~= "disconnected" then
		MenuCallbackHandler:load_start_menu_lobby()
	end
end