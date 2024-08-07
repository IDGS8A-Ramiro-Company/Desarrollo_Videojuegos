/// @description Insert description here
// You can write your code in this editor
accept_key = keyboard_check_pressed(vk_enter);

//Center menu
switch (typeDialog)
{
	case 1:
		width = 200;
		height = 30;
		x = camera_get_view_x(view_camera[0]);
		y = camera_get_view_y(view_camera[0]) + 10;
		break;
		
	case 2:
		width = 300
		height = 60;
		x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - width / 2;
		y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) - height + 20;
		break;
	
	case 3:
		width = 300;
		height = 100;
		x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - width / 2;
		y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - height / 2;
		break;
}


draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);


if(setup == false)
{
	setup = true;
	draw_set_font(fnM5x7);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	pageNumber = array_length(textDialog);
	for(var p = 0; p < pageNumber; p++)
	{
		textLength[p] = string_length(textDialog[p]);
		
		textXOffset[p] = 5;
	}
}

if(drawChar < textLength[page])
{
	drawChar += textSpd;
	drawChar = clamp(drawChar, 0, textLength[page]);
	
}

if(accept_key)
{
	if(drawChar == textLength[page])
	{
		if(page < pageNumber - 1)
		{
			page++;
			drawChar = 0;
		}
		else
		{
			switch(typeDialog)
			{
				case 1:
					instance_destroy();
					break;
					
				case 2:
					room_goto(roomGo);
					instance_destroy();
					break;
					
				case 3:
					game_end();
					break;
			}
		}
	}
	else
	{
		drawChar = textLength[page];
	}
}

txtb_spr_w = sprite_get_width(txtb_spr);
txtb_spr_h = sprite_get_height(txtb_spr);

var _drawText = string_copy(textDialog[page], 1, drawChar);

draw_text_ext(x + textXOffset[page] + border, y + border, _drawText, lineSep, line_width);