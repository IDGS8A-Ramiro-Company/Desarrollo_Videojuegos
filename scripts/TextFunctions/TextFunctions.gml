// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AddText(_text)
{
	textDialog[pageNumber] = _text;
	pageNumber ++;
}

function NewDialog(_type, _roomGo = noone)
{
	typeDialog = _type;
	roomGo = _roomGo;
	for(var i = 0; i < array_length(textDialog); i++)
	{
		array_pop(textDialog);
	}
}

function NewInteraction(_type, _text, _roomGo = noone)
{
	if(!instance_exists(oDialog) && _type != undefined)
	{
		with (instance_create_depth(0, 0, -9999, oDialog))
		{
			NewDialog(_type, _roomGo);
			for(var i = 0; i < array_length(_text); i++)
			{
				AddText(_text[i]);
			}
			
		}
	}
}

