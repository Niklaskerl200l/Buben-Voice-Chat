CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.priority = 1
CLGAMEMODESUBMENU.title = "Title_Addons_Buben_Voice_Chat"

function CLGAMEMODESUBMENU:Populate(parent)
	local Form_Voice_Chat = vgui.CreateTTT2Form(parent, "Header_Proximity_Voice_Chat")
	local Form_Voice_Panels = vgui.CreateTTT2Form(parent, "Header_Voice_Toggle")

	Form_Voice_Chat:MakeHelp({
		label = "Help_Proximity_Voice_Chat"
	})

	Form_Voice_Chat:MakeSlider({
		serverConvar = "Buben_Max_Voice_Range",
		label = "Label_Max_Voice_Range",
		min = 0,
		max = 5000,
		decimal = 0
	})

	Form_Voice_Chat:MakeCheckBox({
		serverConvar = "Buben_Proximity_Chat_Enable",
		label = "Label_Proximity_Chat_Enable",
	})


	-- Form Voice Panels Toggel

	Form_Voice_Panels:MakeHelp({
		label = "Help_Voice_Hide_Panels"
	})

	Form_Voice_Panels:MakeCheckBox({
        serverConvar = "Buben_Voice_Auto_Enable",
        label = "Label_Voice_Auto_Enable"
    })

    Form_Voice_Panels:MakeCheckBox({
        serverConvar = "Buben_Voice_Hide_Panels_Alive",
        label = "Label_Voice_Hide_Panels_Alive"
    })

	Form_Voice_Panels:MakeCheckBox({
        serverConvar = "Buben_Voice_Hide_Panels_Spectator",
        label = "Label_Voice_Hide_Panels_Spectator"
    })
end