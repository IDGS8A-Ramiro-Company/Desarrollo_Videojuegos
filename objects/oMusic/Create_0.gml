/// @description Insert description here
// You can write your code in this editor
//Global music controls
global.masterVolume = 1;
global.musicVolume = 1;

songInstance = noone;
songAsset = noone;
targetSongAsset = noone;
endFadeOutTime = 0;
startFadeInTime = 120;
fadeInInstanceVol = 1;

//For fade out and stop songs 
fadeOutInstances = array_create(0);
fadeOutInstanceVol = array_create(0);
fadeOutInstanceTime = array_create(0);