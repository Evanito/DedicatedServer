_G.DedicatedServer = _G.DedicatedServer or {}

Hooks:PreHook( TradeManager, "update", "DedicatedServerPreTradeManagerupdate", function(t, dt)
	if Utils:IsInHeist() and DedicatedServer and DedicatedServer.Settings and DedicatedServer.Settings.Game_HostBOT_Donnot_Release then
		if managers.trade and managers.trade:does_criminal_exist(1) then
			local _criminals_to_respawn = managers.trade:get_criminals_to_respawn()
			for i, crim in ipairs(_criminals_to_respawn) do
				local _run = false
				if crim and crim.peer_id and type(crim.peer_id) == "number" then
					if crim.peer_id == 1 and not _run then
						_run = true
						managers.trade:remove_criminals_to_respawn(i)
						break
					end
				end
			end
		end
	end
end )

function TradeManager:get_criminals_to_respawn()
	return self._criminals_to_respawn or {}
end

function TradeManager:remove_criminals_to_respawn(id)
	if not id or type(id) ~= "number" then
		return
	end
	table.remove(self._criminals_to_respawn, id)
	self._criminals_to_respawn[id] = {}
end