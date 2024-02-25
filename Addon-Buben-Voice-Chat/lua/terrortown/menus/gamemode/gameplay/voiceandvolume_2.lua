--- @ignore

CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"

CLGAMEMODESUBMENU.priority = 98
CLGAMEMODESUBMENU.title = "submenu_gameplay_voiceandvolume_title_2"
CLGAMEMODESUBMENU.icon = Material("vgui/ttt/vskin/helpscreen/voiceandvolume")

function CLGAMEMODESUBMENU:Populate(parent)
    local form = vgui.CreateTTT2Form(parent, "header_soundeffect_settings")

    -- form:MakeCheckBox({
    --     label = "label_inferface_scues_enable",
    --     convar = "ttt_cl_soundcues",
    -- })

    -- form = vgui.CreateTTT2Form(parent, "header_voiceandvolume_settings")

    -- form:MakeCheckBox({
    --     label = "label_gameplay_mute",
    --     convar = "ttt_mute_team_check",
    -- })

    form:MakeCheckBox({
        label = "label_spactator_mute",
        convar = "ttt_mute_spactator_check",
    })

    cvars.AddChangeCallback("label_spactator_mute", MuteSpactatorCallback)

    -- form:MakeComboBox({
    --     label = "label_voice_scaling",
    --     convar = "ttt2_voice_scaling",
    --     choices = VOICE.GetScalingFunctions(),
    --     OnChange = function()
    --         for _, ply in ipairs(player.GetAll()) do
    --             VOICE.UpdatePlayerVoiceVolume(ply)
    --         end
    --     end,
    -- })

    -- local enbSpecDuck = form:MakeCheckBox({
    --     label = "label_voice_duck_spectator",
    --     convar = "ttt2_voice_duck_spectator",
    -- })

    -- form:MakeSlider({
    --     label = "label_voice_duck_spectator_amount",
    --     convar = "ttt2_voice_duck_spectator_amount",
    --     min = 0,
    --     max = 1,
    --     decimal = 2,
    --     master = enbSpecDuck,
    -- })
end

local function MuteSpactatorCallback(cv, old, new)
    net.Start("TTT2MuteSpactator")
    net.WriteBool(tobool(new))
    net.SendToServer()
end