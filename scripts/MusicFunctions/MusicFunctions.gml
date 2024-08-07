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

function GetCurrentSong()
{
	var _currentSong = noone;
	with (oMusic)
	{
		_currentSong = songAsset;
	}
	return _currentSong;
}

function PauseAndPlay(_state)
{
	switch(_state)
	{
		//Full
		case 1:
			global.masterVolume = global.masterVolume * 4;
			break;
		
		//Pause
		case 2:
			global.masterVolume = global.masterVolume / 4;
			break;
	}
	
}