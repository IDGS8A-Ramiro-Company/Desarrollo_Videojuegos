instance_destroy(oPlayer);
if(!instance_exists(oDialog))
{
	with (instance_create_depth(0, 0, -9999, oDialog))
	{
		NewDialog(DIALOGTYPE.CREDITS);
		AddText("A Ramiro Company Production \nCreditos:\nJesus Angel de la Cruz Vargas \nFrancisco Javier Reyes Reyna \nJose Gabriel Cardenas Vazquez \nAlan Nunez Velazquez");
		AddText("Gracias");
	}
}