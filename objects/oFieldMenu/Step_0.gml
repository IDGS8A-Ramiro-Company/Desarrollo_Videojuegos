/// @description Insert description here
// You can write your code in this editor
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_enter);

//Store Options
op_length = array_length(option[menu_level]);

pos += down_key - up_key;

if(pos >= op_length)
{
	pos = 0;
}
if(pos < 0)
{
	pos = op_length - 1;
}
if(accept_key)
{
	var _sml = menu_level;
	
	switch(menu_level)
	{
		//Initial Menu
		case 0:
			switch(pos)
			{
				//Start Game
				case 0:
					PauseAndPlay(1);
					instance_destroy();
					break;
			
				//Settings
				case 1:
					menu_level = 1;
					break;
			
				//End Game
				case 2:
					game_end();
					break;
			}
			break;
		
		//Settings
		case 1:
			switch(pos)
			{
				//Window Size
				case 0:
					room_goto_next();
					break;
			
				//Brightness
				case 1:
					break;
			
				//Controls
				case 2:
					game_end();
					break;
				
				//Back
				case 3:
					menu_level = 0;
					break;
			}
			break;
	}
	
	if (_sml != menu_level)
	{
		pos = 0;
	}
	op_length = array_length(option[menu_level]);
	
}
