if Network:is_client() then
	return
end

_G.DedicatedServer = _G.DedicatedServer or {}

if not DedicatedServer then
	return
end

function TradeManager:remove_host_from_respawn_list()
	if self:does_criminal_exist(1) then
		for id, crim in ipairs(self._criminals_to_respawn or {}) do
			if type(crim.peer_id) == "number" and crim.peer_id == 1 then
				table.remove(self._criminals_to_respawn, id)
			end
		end
	end
end