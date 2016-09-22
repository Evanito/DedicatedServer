_G.DedicatedServer = _G.DedicatedServer or {}

function TradeManager:remove_host_from_respawn_list()
	if Utils:IsInHeist() then
		return
	end
	if not DedicatedServer then
		return
	end
	if self:does_criminal_exist(1) then
		for id, crim in ipairs(self._criminals_to_respawn or {}) do
			if type(crim.peer_id) == "number" and crim.peer_id == 1 then
				table.remove(self._criminals_to_respawn, id)
				break
			end
		end
	end
end