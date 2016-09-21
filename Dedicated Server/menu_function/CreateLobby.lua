_G.DedicatedServer = _G.DedicatedServer or {}

function DedicatedServer:SetNextHeist(data)
	local _Last_Lobby_Hesitcycle = self.Last_Data.Last_Lobby_Hesitcycle or 0
	local _Lobby_Hesitcycle = self.Settings.Lobby_Hesitcycle or {}
	local _Next_Hesit_Ready = {}
	local _Next_Hesit = {}
	
	_Last_Lobby_Hesitcycle = _Last_Lobby_Hesitcycle + 1
	if _Last_Lobby_Hesitcycle > #_Lobby_Hesitcycle then
		_Last_Lobby_Hesitcycle = 1
	end
	
	self.Last_Data.Last_Lobby_Hesitcycle = _Last_Lobby_Hesitcycle	
	self:Save_Last_Data()
	
	if #_Lobby_Hesitcycle > 0 then
		_Next_Hesit = _Lobby_Hesitcycle[_Last_Lobby_Hesitcycle]
	end
	
	if data and type(data) == "table" and #data > 0 then
		_Next_Hesit = data
	end
	
	_Next_Hesit_Ready = self.Settings.Lobby_Default_Setting
	_Next_Hesit_Ready.job = _Next_Hesit.job or _Next_Hesit_Ready.job
	_Next_Hesit_Ready.difficulty = _Next_Hesit.difficulty or _Next_Hesit_Ready.difficulty
	_Next_Hesit_Ready.permission = _Next_Hesit.permission or _Next_Hesit_Ready.permission
	_Next_Hesit_Ready.min_rep = _Next_Hesit.min_rep or _Next_Hesit_Ready.min_rep
	_Next_Hesit_Ready.drop_in = _Next_Hesit.drop_in or _Next_Hesit_Ready.drop_in
	_Next_Hesit_Ready.kicking_allowed = _Next_Hesit.kicking_allowed or _Next_Hesit_Ready.kicking_allowed
	_Next_Hesit_Ready.team_ai = _Next_Hesit.team_ai or _Next_Hesit_Ready.team_ai
	_Next_Hesit_Ready.auto_kick = _Next_Hesit.auto_kick or _Next_Hesit_Ready.auto_kick
	self:CreateLobby(_Next_Hesit_Ready)
end

function DedicatedServer:CreateLobby(data)
	managers.menu:on_leave_lobby()
	managers.job:on_buy_job(data.job, data.difficulty)
	Global.game_settings.permission = data.permission ~= nil and data.permission or self.Settings.permission
	Global.game_settings.reputation_permission = type(data.min_rep) == "number" and data.min_rep or self.Settings.min_rep
	Global.game_settings.drop_in_allowed = data.drop_in ~= nil and data.drop_in or self.Settings.drop_in
	Global.game_settings.kicking_allowed = data.kicking_allowed ~= nil and data.kicking_allowed or self.Settings.kicking_allowed
	Global.game_settings.team_ai = data.team_ai ~= nil and data.team_ai or self.Settings.team_ai
	Global.game_settings.auto_kick = data.auto_kick ~= nil and data.auto_kick or self.Settings.auto_kick
	MenuCallbackHandler:start_job({job_id = data.job, difficulty = data.difficulty})
end