/// @description Insert description here
// You can write your code in this editor
if (room == rmField)
{
	SetSongInGame( sndBGMEarth, 0, 10*60);
}

if (room == rmCity)
{
	SetSongInGame( sndBGMCity, 30, 0);
}

if(room == rmMainMenu)
{
	SetSongInGame( sndMenu, 30, 0);
}

if(room == rmInitialDialog)
{
	SetSongInGame( sndBGMOpening, 30, 0);
}

if(room == rmCredits)
{
	SetSongInGame( sndBGMCredits, 30, 0);
}

if(room == rmInside)
{
	SetSongInGame( sndBGMInside, 30, 0);
}