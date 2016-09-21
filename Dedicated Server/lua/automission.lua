_G.DedicatedServer = _G.DedicatedServer or {}

if RequiredScript ==  "lib/managers/menumanager" then
	local DedicatedServer_MenuCallbackHandler_buy_crimenet_contract = MenuCallbackHandler._buy_crimenet_contract
	function MenuCallbackHandler:_buy_crimenet_contract(...)
		DedicatedServer:SetNextHeist()
	end
end

if RequiredScript == "lib/managers/menu/contractboxgui" then
	local _announce_bool = false
	local _last_peers = {}
	local DedicatedServer_ContractBoxGui_update = ContractBoxGui.update
	function ContractBoxGui:update(t,...)
		DedicatedServer_ContractBoxGui_update(self,t,...)
		if Utils:IsInHeist() then
			return
		end
		if not DedicatedServer then
			return
		end
		if not t or not type(t) == "number" or t < 10 then
			return
		end
		if not managers.job:current_contact_data() then
			DedicatedServer:SetNextHeist()
			return
		end
		local _Settings = DedicatedServer.Settings
		self._auto_continue_t = self._auto_continue_t or (t + _Settings.Lobby_Time_To_Start_Game)
		local alv = DedicatedServer:GetPeersAmount()
		if t >= self._auto_continue_t then
			if managers.job then
				local contact_data = managers.job:current_contact_data()
				if contact_data and (alv >= _Settings.Lobby_Min_Amount_To_Start or (_Settings.Lobby_Time_To_Forced_Start_Game >= 0 and t >= self._auto_continue_t + _Settings.Lobby_Time_To_Forced_Start_Game)) then
					MenuCallbackHandler:start_the_game()
				end
			end
		else
			if _Settings.Lobby_Do_Countdown_Before_Start_Game > 0 then
				local tickkk = math.round(self._auto_continue_t - t)
				if (tickkk%_Settings.Lobby_Do_Countdown_Before_Start_Game) == 0 and not _announce_bool then
					_announce_bool = true
					managers.chat:send_message(ChatManager.GAME, "[Auto-Looby]",  "Game will start in " .. tostring(tickkk) .. "s")
				end
				if (tickkk%_Settings.Lobby_Do_Countdown_Before_Start_Game) ~= 0 and _announce_bool then
					_announce_bool = false
				end
			end
		end
	end
end