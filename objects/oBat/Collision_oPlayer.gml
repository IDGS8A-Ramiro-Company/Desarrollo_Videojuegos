/// @description Insert description here
// You can write your code in this editor
if(!instance_exists(oBattleWarp) && !instance_exists(oBattle))
{
	NewBattleAnimation([global.enemies.bat, global.enemies.bat], sBgCity);
}
//SetSongInGame(sndBattleStart, 0, 0);
//instance_destroy();