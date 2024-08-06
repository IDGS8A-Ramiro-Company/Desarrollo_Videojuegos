var _inputH = keyboard_check(vk_right) - keyboard_check(vk_left);
var _inputV = keyboard_check(vk_down) - keyboard_check(vk_up);
var _inputD = point_direction(0,0,_inputH,_inputV);
var _inputM = point_distance(0,0,_inputH,_inputV);
var _inputEsc = keyboard_check_pressed(vk_escape);


if (_inputM != 0 && !instance_exists(oPauser))
{
	direction = _inputD;	
	image_speed = 1;
}
else
{
	image_speed = 0;
	animIndex = 0;
}



xspd = lengthdir_x(spdWalk*_inputM,_inputD);
yspd = lengthdir_y(spdWalk*_inputM,_inputD);

//Check for collisions
if (place_meeting(x + xspd, y, oWall) == true)
{
	xspd = 0;
}

if (place_meeting(x, y + yspd, oWall) == true)
{
	yspd = 0;
}

if (instance_exists(oPauser))
{
	xspd = 0;
	yspd = 0;
}

FourDirectionAnimate();

x += xspd
y += yspd

//Depth
depth = -bbox_bottom;

if(_inputEsc)
{
	if(!instance_exists(oMainMenu))
	{
		PauseAndPlay(2);
	instance_create_depth(0, 0, -99999, oFieldMenu);
	}
}