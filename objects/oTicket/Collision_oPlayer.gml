/// @description Insert description here
// You can write your code in this editor
if(!instance_exists(oCroc))
{
	if(!instance_exists(oDialog))
	{
		with (instance_create_depth(0, 0, -9999, oDialog))
		{
			NewDialog(DIALOGTYPE.STORY, rmCredits);
			AddText("Conseguiste el boleto Dorado");
			AddText("Ahora por fin podras entrar al siguiente concierto");
			AddText("Capitulo 1: FIN");
		}
	}
}
