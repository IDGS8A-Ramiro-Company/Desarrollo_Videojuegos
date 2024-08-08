keyLeft = keyboard_check(ord("A")) || keyboard_check(vk_left);
keyRight = keyboard_check(ord("D")) || keyboard_check(vk_right);
keyUp = keyboard_check(ord("W")) || keyboard_check(vk_up);
keyDown = keyboard_check(ord("S")) || keyboard_check(vk_down);

var _inputH = keyRight - keyLeft;
var _inputV = keyDown - keyUp;

var _inputD = point_direction(0,0,_inputH,_inputV);
var _inputM = point_distance(0,0,_inputH,_inputV);
var _inputEsc = keyboard_check_pressed(vk_escape);
var _inputEnt = keyboard_check_pressed(vk_enter);


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

if(_inputEnt)
{
	var _activateX = lengthdir_x(15, direction);
	var _activateY = lengthdir_y(15, direction);
	activate = instance_position(x + _activateX, y + _activateY, oEntities);
	
	//Show message that nothing is there
	if(activate == noone || activate.entityActivateScript == -1)
	{
		if(!instance_exists(oDialog))
		{
			with (instance_create_depth(0, 0, -9999, oDialog))
			{
				NewDialog(DIALOGTYPE.NORMAL);
				AddText("No hay nada aqui");
			}
		}
	}
	//Activate entity
	else
	{
		script_execute_ext(activate.entityActivateScript, activate.entityActivateArgs);
		
		if(activate.entityNPC)
		{
			with(activate)
			{
				direction = point_direction(x, y, other.x, other.y);
			}
		}
	}
}