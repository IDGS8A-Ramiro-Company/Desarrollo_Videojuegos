/// @description Insert description here
// You can write your code in this editor
if(text != "")
{
	var _w = string_width(text) + 20;
	draw_sprite_stretched(sBox, 0, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]) - 50, _w, 60);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]) - 50, text);
}