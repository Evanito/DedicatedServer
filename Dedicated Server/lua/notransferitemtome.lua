local _DedicatedServer_PlayerManager_transfer_special_equipment = PlayerManager.transfer_special_equipment

function PlayerManager:transfer_special_equipment(peer_id, include_custody)
	_DedicatedServer_PlayerManager_transfer_special_equipment(self, peer_id, include_custody)
	if peer_id == 1 then
		self:transfer_special_equipment(1)
	end
end