/// @description Insert description here
// You can write your code in this editor
accept_key = keyboard_check_pressed(vk_enter);


textBox_X = camera_get_view_x(view_camera[0]);
textBox_Y = camera_get_view_y(view_camera[0]) + 10;




if(setup == false)
{
	setup = true;
	draw_set_font(fnM5x7);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);
	
	pageNumber = array_length(text);
	for(var p = 0; p < pageNumber; p++)
	{
		textLength[p] = string_length(text[p]);
		
		textXOffset[p] = 30;
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
			instance_destroy();
		}
	}
	else
	{
		drawChar = textLength[page];
	}
}

txtb_spr_w = sprite_get_width(txtb_spr);
txtb_spr_h = sprite_get_height(txtb_spr);
draw_sprite_ext(txtb_spr, txtb_img, textBox_X + textXOffset[page], textBox_Y, textBoxWidth/txtb_spr_w, textBoxHeight/txtb_spr_h, 0, c_white, 1);

var _drawText = string_copy(text[page], 1, drawChar);

draw_text_ext(textBox_X + textXOffset[page] + border, textBox_Y + border, _drawText, lineSep, line_width);
