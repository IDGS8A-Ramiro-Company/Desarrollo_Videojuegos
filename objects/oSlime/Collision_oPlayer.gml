audio_pause_all();
audio_play_sound(sndBattleStart, 0, false);
while audio_is_playing(sndBattleStart) {}
NewEncounter([global.enemies.slimeG, global.enemies.slimeG], sBgCity);