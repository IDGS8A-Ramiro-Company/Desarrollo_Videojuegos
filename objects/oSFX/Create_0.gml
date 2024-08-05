/// @description Insert description here
// You can write your code in this editor
global.sfxVolume = 1;

sfxInstance = noone;
sfxAsset = noone;
targetsfxAsset = noone;
endFadeOutTime = 0;
startFadeInTime = 120;
fadeInInstanceVol = 1;

//For fade out and stop songs 
fadeOutInstances = array_create(0);
fadeOutInstanceVol = array_create(0);
fadeOutInstanceTime = array_create(0);