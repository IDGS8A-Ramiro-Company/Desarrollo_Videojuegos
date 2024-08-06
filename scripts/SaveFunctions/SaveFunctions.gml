// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SaveRoom()
{
	var _healBoxesNum = instance_number(oHealBox);
	var _roomStruct = 
	{
		healBoxesNum : _healBoxesNum,
		healBoxesData : array_create(_healBoxesNum),
	}
	
	//Heal Boxes
	for(var i = 0; i < _healBoxesNum; i++)
	{
		var _inst = instance_find(oHealBox, i);
		_roomStruct.healBoxesData[i] = 
		{
			x: _inst.x,
			y: _inst.y,
		}
	}
	
	//Store to Room
	if (room = rmField) 
	{
		global.levelData.level1 = _roomStruct;
	}
	if (room = rmCity) 
	{
		global.levelData.level2 = _roomStruct;
	}
	if (room = rmInside) 
	{
		global.levelData.level3 = _roomStruct;
	}
}


function LoadRoom()
{
	var _roomStruct = 0;
	
	if(room = rmField)
	{
		_roomStruct = global.levelData.level1;
	}
	if(room = rmCity)
	{
		_roomStruct = global.levelData.level2;
	}
	if(room = rmInside)
	{
		_roomStruct = global.levelData.level3;
	}
	
	if(!is_struct(_roomStruct))
	{
		exit;
	}
	
	//Heal Boxes
	if (instance_exists(oHealBox))
	{
		instance_destroy(oHealBox);
	}
	
	for (var i = 0; i < _roomStruct.healBoxesNum; i++)
	{
		instance_create_layer(_roomStruct.healBoxesData[i].x, _roomStruct.healBoxesData[i].y, layer, oHealBox);
	}
}