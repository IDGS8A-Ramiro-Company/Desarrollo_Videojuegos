/// @description Insert description here
// You can write your code in this editor
for(var i = 0; i < array_length(global.party); i++)
{
	global.party[i].hp = global.party[i].hpMax;
	global.party[i].mp = global.party[i].mpMax;
}

//if(!instance_exists(oTextBox))
//{
//	with (instance_create_depth(0, 0, -9999, oTextBox))
//	{
//		AddText("Your Party is fully healed")
//	}
//}

if(!instance_exists(oDialog))
{
	with (instance_create_depth(0, 0, -9999, oDialog))
	{
		NewDialog(DIALOGTYPE.NORMAL);
		AddText("Tu y tus amigos han sido curados");
	}
}

instance_destroy();


