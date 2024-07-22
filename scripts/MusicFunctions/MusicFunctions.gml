// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetSongInGame( _song, _fadeOutCurrentSong = 0, _fadeInNextSong = 0)
{
	with (oMusic)
	{
		targetSongAsset = _song;
		endFadeOutTime = _fadeOutCurrentSong;
		startFadeInTime = _fadeInNextSong;
	}
}