--AddCSLuaFile()

CreateConVar("Buben_Voice_Range_Whisper", 500, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The Whisper Maximum distance for listener to still be able to hear the talker.")
CreateConVar("Buben_Voice_Range_Normal",1500,{ FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The Normal Maximum distance for listener to still be able to hear the talker.")
CreateConVar("Buben_Voice_Range_Shout", 3000, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The Shout Maximum distance for listener to still be able to hear the talker.")
CreateConVar("Buben_Voice_Auto_Enable", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Automatically enable voice chat for players when they join")
CreateConVar("Buben_Voice_Hide_Panels_Alive", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Hide the voice panels that show who else is talking when player is alive")
CreateConVar("Buben_Voice_Hide_Panels_Spectator", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Hide the voice panels that show who else is talking when player is Spectating")