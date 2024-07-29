/// @description Insert description here
// You can write your code in this editor
//Play target song
if (songAsset != targetSongAsset)
{
	
	if (audio_is_playing(songInstance))
	{
		array_push(fadeOutInstances, songInstance);
		
		array_push(fadeOutInstanceVol, fadeInInstanceVol);
		
		array_push(fadeOutInstanceTime, endFadeOutTime);
		
		songInstance = noone;
		songAsset = noone;
	}
	
	if (array_length(fadeOutInstances) == 0)
	{
		if audio_exists(targetSongAsset)
		{
			songInstance = audio_play_sound(targetSongAsset, 4, true);
	
			audio_sound_gain(songInstance, 0, 0);
			fadeInInstanceVol = 0;
		}
	
		songAsset = targetSongAsset;
	}
}


var _finalVolume = global.musicVolume * global.masterVolume;

//Volume control
if audio_is_playing(songInstance)
{
	if (startFadeInTime > 0)
	{
		if (fadeInInstanceVol < 1) 
		{ 
			fadeInInstanceVol += 1/startFadeInTime; 
		} 
		else 
		{
			fadeInInstanceVol = 1;
		}
	}
	else 
	{
		fadeInInstanceVol = 1;
	}
	
	audio_sound_gain(songInstance, fadeInInstanceVol * _finalVolume, 0);
}

for (var i = 0; i < array_length(fadeOutInstances); i++)
{
	if (fadeOutInstanceTime[i] > 0)
	{
		if (fadeOutInstanceVol[i] > 0)
		{
			fadeOutInstanceVol[i] -= 1/fadeOutInstanceTime[i];
		}
	}
	else
	{
		fadeOutInstanceVol[i] = 0;
	}
	
	audio_sound_gain(fadeOutInstances[i], fadeOutInstanceVol[i] * _finalVolume, 0);
	
	if (fadeOutInstanceVol[i] <= 0)
	{
		if (audio_is_playing(fadeOutInstances[i]))
		{
			audio_stop_sound(fadeOutInstances[i]);
		}
		
		array_delete(fadeOutInstances, i, 1);
		array_delete(fadeOutInstanceVol, i, 1);
		array_delete(fadeOutInstanceTime, i, 1);
		
		i--;
	}
}