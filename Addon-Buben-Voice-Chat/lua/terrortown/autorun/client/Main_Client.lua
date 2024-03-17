print("Buben Voice Chat v2.1.3 by Niklaskerl2001")

--AddCSLuaFile()

--------------------------------- Funktionen ---------------------------------

function voice_enable()
    if TTT2 then
        if VOICE.CanSpeak() == false then return false end
        if hook.Run("TTT2CanUseVoiceChat", LocalPlayer(), false) == false then return false end
    end

    permissions.EnableVoiceChat(true)
    return true
end


function voice_disable()
    permissions.EnableVoiceChat(false)
    return true
end


function voice_toggle()
    if (TTT2 and VOICE.IsSpeaking() == false) then
        return voice_enable()
    else
        return voice_disable()
    end
end


function Voice_Auto_Enable()
    if GetConVar("Buben_Voice_Auto_Enable"):GetBool() then 
        voice_enable() 
    end 
end

-- Voice Chat Relod um im Panel die Richtige Farbe anzuzeigen (gelb oder grün)
function Voice_Chat_Relode(len) 
    if (TTT2 and VOICE.IsSpeaking() == true) then
        voice_toggle()
        timer.Simple(1, function() voice_toggle() end)
    end
end



function TTT2Initialize()

    Register_Keys_Client()

    foo()
end

function foo(arguments)
    
    local old_PlayerStartVoice = GAMEMODE.PlayerStartVoice  -- disable top-left voice panels that show who else is talking
    
    function GAMEMODE:PlayerStartVoice(ply)
        local client = LocalPlayer()

        old_PlayerStartVoice(self, ply)

        if GetConVar("Buben_Voice_Hide_Panels_Alive"):GetBool() == false then return end
        if GetConVar("Buben_Voice_Hide_Panels_Spectator"):GetBool() == false and client:IsSpec() then return end

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

function Register_Keys_Client()
    bind.Register(
        "voice_toggle",
        voice_toggle,
        function() return true end,
        "Buben Voice Chat",
        "Label_Voice_Toggle_Key",
        KEY_H
    )

    bind.Register(
        "Voice_Whisper",
        PlayerButtonDown_Whisper,
        PlayerButtonUp_Whisper,
        "Buben Voice Chat",
        "Label_Voice_Whisper_Key",
        KEY_X
    )

    bind.Register(
        "Voice_Shout",
        PlayerButtonDown_Shout,
        PlayerButtonUp_Shout,
        "Buben Voice Chat",
        "Label_Voice_Shout_Key",
        KEY_G
    )
end

--------------------------------- Show Voice Range ---------------------------------


function PlayerButtonDown_Whisper()
    print(GetConVar("Buben_Voice_Hide_Panels_Alive"):GetBool())
    LocalPlayer():SetNWBool("Whisper", true)
end

function PlayerButtonUp_Whisper()
    LocalPlayer():SetNWBool("Whisper", false)
end

function PlayerButtonDown_Shout()
    LocalPlayer():SetNWBool("Shout", true)
end

function PlayerButtonUp_Shout()
    LocalPlayer():SetNWBool("Shout", false)
end

function Show_Voice_Range()
    local ply = LocalPlayer()
    local Whisper = ply:GetNWBool("Whisper", false)
    local Shout = ply:GetNWBool("Shout", false)
    
    if Whisper == true or Shout == true then
        local pos = ply:GetPos()
        local ang = Angle(0, 0, 0)

        pos.z = pos.z + 1 -- adjust z to draw just above the ground

        if Whisper == true and Shout == false then 

            cam.Start3D2D(pos, ang, 1)
                cam.IgnoreZ(true) -- Ignoriere die Tiefenprüfung
                surface.SetDrawColor(255, 255, 255, 255) -- Set the draw color (R, G, B, A)
                surface.DrawCircle(0, 0, GetConVar("Buben_Voice_Range_Whisper"):GetInt())
                cam.IgnoreZ(false) -- Setze die Tiefenprüfung zurück
            cam.End3D2D()

        elseif Shout == true then

            cam.Start3D2D(pos, ang, 1)
                cam.IgnoreZ(true) -- Ignoriere die Tiefenprüfung
                surface.SetDrawColor(255, 255, 255, 255) -- Set the draw color (R, G, B, A)
                surface.DrawCircle(0, 0, GetConVar("Buben_Voice_Range_Shout"):GetInt())
                cam.IgnoreZ(false) -- Setze die Tiefenprüfung zurück
            cam.End3D2D()

        end
    end
end

--------------------------------- Hooks ---------------------------------


hook.Add("InitPostEntity", "Voice_Auto_Enable", Voice_Auto_Enable)
hook.Add("TTT2Initialize", "voice_toggle/TTT2Initialize", TTT2Initialize)
hook.Add("PostDrawOpaqueRenderables", "Draw Voice Range", Show_Voice_Range)

net.Receive("Spieler_Tot_an_Client", Voice_Chat_Relode)
net.Receive("Spieler_Spawn_an_Client", Voice_Chat_Relode)

concommand.Add("voice_toggle", function(_ply, _cmd, _args, _argStr) voice_toggle() end, nil, "Toggle Global Voice Chat")