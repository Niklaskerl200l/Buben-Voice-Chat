util.AddNetworkString( "Spieler_Tot_an_Client")
util.AddNetworkString( "Spieler_Spawn_an_Client")

CreateConVar("Buben_Max_Voice_Range",1500,FCVAR_ARCHIVE,"Maximum distance for listener to still be able to hear the talker.")
CreateConVar("Buben_Proximity_Chat_Enable",1,FCVAR_ARCHIVE,"Enables/disables proximity chat.")
CreateConVar("Buben_Voice_Auto_Enable", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Automatically enable voice chat for players when they join.")
CreateConVar("Buben_Voice_Hide_Panels_Alive", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Hide the voice panels in the top-left corner that show who else is talking.")
CreateConVar("Buben_Voice_Hide_Panels_Spectator", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Hide the voice panels in the top-left corner that show who else is talking when you player is Spectating.")