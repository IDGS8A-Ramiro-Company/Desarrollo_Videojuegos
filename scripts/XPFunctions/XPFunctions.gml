// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UpdateExp(_char, _xp)
{
	global.party[_char].experience += _xp;
	if (global.party[_char].experience > global.party[_char].maxExp)
	{
		var _extraHP = irandom_range(3,10);
		var _extraMP = irandom_range(3,10);
		
		global.party[_char].lvl ++;
		CheckForLvlUp(_char, global.party[_char].lvl);
		global.party[_char].experience -= global.party[_char].maxExp;
		global.party[_char].hpMax += _extraHP;
		if(global.party[_char].hp > 0)
		{
			global.party[_char].hp += _extraHP;
		}
		global.party[_char].mpMax += _extraMP;
		global.party[_char].mp += _extraMP;
		global.party[_char].maxExp += 30;
		global.party[_char].strength += global.levelUps[_char].strength
		
	}
}

function CheckForLvlUp(_char, _lvl)
{
	for(var i = 0; i < array_length(global.levelUps[_char].levels); i++)
	{
		if(global.levelUps[_char].levels[i].level == _lvl)
		{
			array_push(global.party[_char].actions, global.levelUps[_char].levels[i].action)
		}
		
	}
	
}