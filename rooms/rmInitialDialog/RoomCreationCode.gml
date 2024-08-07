if(!instance_exists(oDialog))
{
	with (instance_create_depth(0, 0, -9999, oDialog))
	{
		NewDialog(DIALOGTYPE.STORY, rmField);
		AddText("Hoy comienza tu aventura por conseguir el ticket dorado");
		AddText("Necesitas ir hacia el norte");
		AddText("Y necesitaras vencer al cocodrilo con el ticket");
		AddText("Adelante, consigue ese ticket!");
	}
}