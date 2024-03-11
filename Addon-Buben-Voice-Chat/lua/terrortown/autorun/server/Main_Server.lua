print("Buben Voice Chat v2.1.4 by Niklaskerl2001")

--------------------------------- Funktionen ---------------------------------

local isSpecialVoiceRangeActive = {}

function Proximity_Voice_Chat (listener,talker)
	-- Wenn Runde nicht läuf hören sich alle & überall
	if GetRoundState() ~= ROUND_ACTIVE then
		return true, GetConVar("Buben_Proximity_Chat_Enable_Always"):GetBool()
	
	-- Das sich die Spectater gegenseitig hören
	elseif listener:IsSpec() and talker:IsSpec() then
		return true, false

	-- Das Lebende Spectater nicht hören
	elseif talker:IsSpec() then
		return false, false

	
	--elseif (tonumber( listener:GetPos():Distance( talker:GetPos() ) ) > tonumber( GetConVar("Buben_Voice_Range_Normal"):GetInt())) then 
	--	return false, false

	-- Das sich die Spieler nicht höhren wenn sie zu weit weg sind
	elseif (tonumber(listener:GetPos():Distance(talker:GetPos())) > (isSpecialVoiceRangeActive[talker] and 500 or tonumber(GetConVar("Buben_Voice_Range_Normal"):GetInt()))) then	--TODO
		--print(isSpecialVoiceRangeActive[talker])
		return false, false

	-- Das sich alle in der Runde höhren die in der Nähe sind
	else 
		return true, GetConVar("Buben_Proximity_Chat_Enable"):GetBool()
	end
end


function Spieler_Tot_an_Client(victim, inflictor, attacker)
	net.Start("Spieler_Tot_an_Client")
	net.Send(victim)
end


function Spieler_Spawn_an_Client(player, transition)
	net.Start("Spieler_Spawn_an_Client")
	net.Send(player)
end


--------------------------------- Hooks ---------------------------------


hook.Add("PlayerCanHearPlayersVoice","Proximity Chat", Proximity_Voice_Chat)
hook.Add("PlayerDeath", "Spieler Tot", Spieler_Tot_an_Client)
hook.Add("PlayerSpawn", "Spieler Spawn", Spieler_Spawn_an_Client)

-- Event, das ausgelöst wird, wenn der Spieler eine Taste drückt
hook.Add("PlayerButtonDown", "Special Voice Range Button Down", function(player, button)
    -- Wenn die Taste die gewünschte Taste ist (z.B. KEY_X für die B-Taste)
    if button == KEY_X then
		print("Server Active")
        isSpecialVoiceRangeActive[player] = true
    end
end)

-- Event, das ausgelöst wird, wenn der Spieler eine Taste loslässt
hook.Add("PlayerButtonUp", "Special Voice Range Button Up", function(player, button)
    -- Wenn die Taste die gewünschte Taste ist
    if button == KEY_X then
		print("Server Inactive")
        isSpecialVoiceRangeActive[player] = false
    end
end)