print("Buben Voice Chat v2.1.6 by Niklaskerl2001")

AddCSLuaFile()

local sandbox_is_speaking = false

local CV_Auto_Enable = CreateConVar("Buben_Voice_Auto_Enable", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Automatically enable voice chat for players when they join")
local CV_Hide_Panels_Alive = CreateConVar("Buben_Voice_Hide_Panels_Alive", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Hide the voice panels that show who else is talking when player is alive")
local CV_Hide_Panels_Spectator = CreateConVar("Buben_Voice_Hide_Panels_Spectator", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Hide the voice panels that show who else is talking when player is Spectating")


--------------------------------- Funktionen ---------------------------------


function voice_enable()
    if TTT2 then
        if VOICE.CanSpeak() == false then return false end
        if hook.Run("TTT2CanUseVoiceChat", LocalPlayer(), false) == false then return false end
    end

    permissions.EnableVoiceChat(true)
    sandbox_is_speaking = true
    return true
end


function voice_disable()
    permissions.EnableVoiceChat(false)
    sandbox_is_speaking = false
    return true
end


function voice_toggle()
    if (TTT2 and VOICE.IsSpeaking() == false) or sandbox_is_speaking == false then
        return voice_enable()
    else
        return voice_disable()
    end
end


function Voice_Auto_Enable()
    if CV_Auto_Enable:GetBool() then 
        voice_enable() 
    end 
end

-- Voice Chat Relod um im Panel die Richtige Farbe anzuzeigen (gelb oder grün)
function Voice_Chat_Relode(len) 
    if (TTT2 and VOICE.IsSpeaking() == true) or sandbox_is_speaking == true then
        voice_toggle()
        timer.Simple(1, function() voice_toggle() end)
    end
end


function Voice_Chat_Initialize()
    -- key binding for toggling voice chat
    bind.Register(
        "voice_toggle",
        voice_toggle,
        function() return true end,
        "header_bindings_ttt2",
        "Toggle Global Voice Chat",
        KEY_H
    )

    -- disable top-left voice panels that show who else is talking
    local old_PlayerStartVoice = GAMEMODE.PlayerStartVoice
    
    function GAMEMODE:PlayerStartVoice(ply)
        local client = LocalPlayer()

        old_PlayerStartVoice(self, ply)

        if CV_Hide_Panels_Alive:GetBool() == false then return end
        if CV_Hide_Panels_Spectator:GetBool() == false and client:IsSpec() then return end

        if IsValid(g_VoicePanelList) == false or IsValid(ply) == false then return end

        -- get the newly created voice panel
        local new_panel_index = g_VoicePanelList:ChildCount() - 1
        local pnl = g_VoicePanelList:GetChild(new_panel_index)

        if pnl.ply ~= client then
            -- immediately hide and delete all other players' panels
            pnl:SetAlpha(0)
            pnl:Remove()
        end
    end
end


--------------------------------- Hooks ---------------------------------


hook.Add("InitPostEntity", "Voice_Auto_Enable", Voice_Auto_Enable)
hook.Add("TTT2Initialize", "voice_toggle/TTT2Initialize", Voice_Chat_Initialize)

net.Receive("Spieler_Tot_an_Client", Voice_Chat_Relode)
net.Receive("Spieler_Spawn_an_Client", Voice_Chat_Relode)

concommand.Add("voice_toggle", function(_ply, _cmd, _args, _argStr) voice_toggle() end, nil, "Toggle Global Voice Chat")