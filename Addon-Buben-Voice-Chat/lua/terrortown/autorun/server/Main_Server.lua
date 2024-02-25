print("Buben Voice Chat v2.1.3 by Niklaskerl2001")

--------------------------------- Funktionen ---------------------------------

local function Proximity_Voice_Chat (listener,talker)
	-- Wenn Runde nicht läuf hören sich alle & überall
	if GetRoundState() ~= ROUND_ACTIVE then
		return true, false
	
	-- Das sich die Spectater gegenseitig hören
	elseif listener:IsSpec() and talker:IsSpec() then
		
		return true, false

	-- Das Lebende Spectater nicht hören
	elseif talker:IsSpec() then
		return false, false

	-- Das sich die Spieler nicht höhren wenn sie zu weit weg sind
	elseif (tonumber( listener:GetPos():Distance( talker:GetPos() ) ) > tonumber( GetConVar("Buben_Max_Voice_Range"):GetInt())) then 
		return false, false

	-- Das sich alle in der Runde höhren die in der Nähe sind
	else 
		return true, GetConVar("Buben_Proximity_Chat_Enable"):GetBool()
	end
end


local function Spieler_Tot_an_Client(victim, inflictor, attacker)
	net.Start("Spieler_Tot_an_Client")
	net.Send(victim)
end


local function Spieler_Spawn_an_Client(player, transition)
	net.Start("Spieler_Spawn_an_Client")
	net.Send(player)
end

local function NetMuteTeam(len, ply)
    local state = net.ReadBool()

    -- TODO Mute
end
--------------------------------- Hooks ---------------------------------


hook.Add("PlayerCanHearPlayersVoice","Proximity Chat", Proximity_Voice_Chat)
hook.Add("PlayerDeath", "Spieler Tot", Spieler_Tot_an_Client)
hook.Add("PlayerSpawn", "Spieler Spawn", Spieler_Spawn_an_Client)



net.Receive("TTT2MuteSpactator", NetMuteTeam)