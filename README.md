# DedicatedServer (WIP)

http://steamcommunity.com/sharedfiles/filedetails/?id=767516193

This Mod will auto open lobby, wait player, start the game and repeat.

##How to Change Settings?

If there is no [Settings.txt](Dedicated Server/cfg/Settings.txt), it will use Default.

Default is in [Main_Menu.lua](Dedicated Server/menu_function/Main_Menu.lua)

Delete (not clean) Settings.txt when something is wrong.

##Settings
###Lobby_Name
string

Lobby Name

###Lobby_Announce_When_Someone_Join
{string, string, ...}

Message to who is joining

###Lobby_Min_Amount_To_Start
number, amount

Minimum player amount to play the game or it will back to planning phase.

###Lobby_Time_To_Start_Game
number, second

After this time up, it will leave planning phase and ready to do heist.

###Lobby_Do_Countdown_Before_Start_Game
number, second, 0 = OFF

A countdown that tell you how long you need to wait for.

###Lobby_Default_Setting
{table}

A basic lobby setting.

###Lobby_Hesitcycle
{table}

A Hesit-cycle list, this setting will be used when cycle is on it.

###Game_Send_HostBOT_To_Jail
bool

Send you, host, bot to jail so others can play the game without you.

###Game_HostBOT_Donnot_Release
bool

Don't release\trade you, host, bot to jail so others can play the game without you.

###Game_Cancel_Hesit_Casue_Wait_Too_Long
number, second, -1 = OFF

Force to cancel when stuck in 'ready to do heist' too long.

###Game_Announce_When_Ready_To_Start
{string, string, ...}

Message when we enter 'ready to do heist'.
