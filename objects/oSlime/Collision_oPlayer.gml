if(!instance_exists(oBattleWarp))
{
	NewBattleAnimation([global.enemies.slimeG, global.enemies.slimeG], sBgCity);
}
SetSongInGame(sndBattleStart, 0, 0);
instance_destroy(self);