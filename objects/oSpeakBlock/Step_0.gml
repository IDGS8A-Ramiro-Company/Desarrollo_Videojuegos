/// @description Insert description here
// You can write your code in this editor
if(position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_left))
{
	with(instance_create_depth(0,0,-9999, oTextBox))
	{
		AddText("Your party is fully healed")
	}
}