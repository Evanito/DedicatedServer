local DedicatedServer_MissionBriefingGui_update = MissionBriefingGui.update
function MissionBriefingGui:update(t, dt)
	DedicatedServer_MissionBriefingGui_update(self, t, dt)
	if t > 7 and not self._ready then
		self:on_ready_pressed()
	end
end