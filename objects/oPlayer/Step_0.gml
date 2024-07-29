var _inputH = keyboard_check(vk_right) - keyboard_check(vk_left);
var _inputV = keyboard_check(vk_down) - keyboard_check(vk_up);
var _inputD = point_direction(0,0,_inputH,_inputV);
var _inputM = point_distance(0,0,_inputH,_inputV);



if (_inputM != 0)
{
	direction = _inputD;	
	image_speed = 1;
}
else
{
	image_speed = 0;
	animIndex = 0;
}

FourDirectionAnimate();

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

x += xspd
y += yspd

//Depth
depth = -bbox_bottom;

