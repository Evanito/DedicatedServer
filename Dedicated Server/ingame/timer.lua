if Network:is_client() then
	return
end

_G.DedicatedServer = _G.DedicatedServer or {}

if not DedicatedServer then
	return
end

local _t_delay = 0

local _send_bot_tojail = false

Hooks:Add("GameSetupUpdate", "BotFixDrillGameSetupUpdate", function(t, dt)
	if Utils:IsInHeist() then
		if t > _t_delay then
			_t_delay = math.round(t) + 1
			if not _send_bot_tojail and DedicatedServer.Settings.Game_Send_HostBOT_To_Jail and t > 7 then
				_send_bot_tojail = true
				local player = managers.player:local_player()
				managers.player:force_drop_carry()
				managers.statistics:downed({ death = true })
				IngameFatalState.on_local_player_dead()
				game_state_machine:change_state_by_name("ingame_waiting_for_respawn")
				player:character_damage():set_invulnerable(true)
				player:character_damage():set_health(0)
				player:base():_unregister()
				player:base():set_slot(player, 0)
				return
			end
			if DedicatedServer.Settings.Game_HostBOT_Donnot_Release then
				managers.trade:remove_host_from_respawn_list()
			end
			local alv = DedicatedServer:GetPeersAmount()
			if alv < DedicatedServer.Settings.Lobby_Min_Amount_To_Start and game_state_machine:current_state_name() ~= "disconnected" then
				MenuCallbackHandler:load_start_menu_lobby()
			end
		end
	end
end)