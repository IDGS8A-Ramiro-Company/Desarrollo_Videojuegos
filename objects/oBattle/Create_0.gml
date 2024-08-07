//instance_deactivate_all(true);
//instance_deactivate_layer("Instances")
instance_deactivate_object(oField)

units = [];

turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];
pages = [];
pageNum = 0;
victoryText = "You Won";

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 60;
battleWaitTimeRemaining = 0;
battleText = "";
currentUser = noone;
currentAction = -1;
currentTargets = noone;


//Targetting Cursor
cursor =
{
	activeUser: noone,
	activeTarget: noone,
	activeAction: -1,
	targetSide: -1,
	targetIndex: 0,
	targetAll: false,
	confirmDelay: 0,
	active: false
}


for (var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x + 250 +(i*10), y+68+(i*20), depth - 10, oBattleUnitEnemy, enemies[i])
	array_push(units, enemyUnits[i]);
}

for (var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x + 70 +(i*10), y+68+(i*15), depth - 10, oBattleUnitPC, global.party[i])
	array_push(units, partyUnits[i]);
}

//Shuffle turn order
unitTurnOrder = array_shuffle(units);

//Get render order
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder, function(_1,_2)
	{
		return _1.y - _2.y;
	});
}

RefreshRenderOrder();

SetSongInGame(sndBGMBattle, 0, 0);
function BattleStateSelectAction()
{
	if(!instance_exists(oMenu))
	{
		
		//Get current unit 
		var _unit = unitTurnOrder[turn];
	
		//Is the unit dead or unable too act?
		if(!instance_exists(_unit)) || (_unit.hp <= 0)
		{
			battleState = BattleStateVictoryCheck;
			exit;
		}
	
		//Select an action to perform
		//BeginAction(_unit.id, global.actionLibrary.attack, _unit.id)
	
		//If unit is player controlled
		if(_unit.object_index == oBattleUnitPC)
		{
			//var _action = global.actionLibrary.attack;
			//var _possibleTargets = array_filter(oBattle.enemyUnits, function(_unit, _index)
			//{
			//	return (_unit.hp > 0);
			//});
			//var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			//BeginAction(_unit.id, _action, _target);
			var _menuOptions = [];
			var _subMenus = {};
			
			var _actionList = _unit.actions;
			
			for(var i = 0; i < array_length(_actionList); i++)
			{
				var _action = _actionList[i];
				var _available = true;
				var _nameAndCount = _action.name;
				if(_action.subMenu == -1)
				{
					array_push(_menuOptions, [_nameAndCount, MenuSelectAction, [_unit, _action], _available]);
				}
				else
				{
					if (is_undefined(_subMenus[$ _action.subMenu]))
					{
						variable_struct_set(_subMenus, _action.subMenu, [[_nameAndCount, MenuSelectAction, [_unit, _action], _available]]);
					}
					else
					{
						array_push(_subMenus[$ _action.subMenu], [_nameAndCount, MenuSelectAction, [_unit, _action], _available]);
					}
				}
			}
			
			var _subMenusArray = variable_struct_get_names(_subMenus);
			
			for (var i = 0; i < array_length(_subMenusArray); i++)
			{
				array_push(_subMenus[$ _subMenusArray[i]], ["Back", MenuGoBack, -1, true]);
					
				array_push(_menuOptions, [_subMenusArray[i], SubMenu, [_subMenus[$ _subMenusArray[i]]], true]);
			}
			Menu(x + 10, y + 110, _menuOptions, , 74, 60);
			
		}
		else
		{
			var _enemyAction = _unit.AIscript();
			if(_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1])
		}
	}
}

function BeginAction(_user, _action, _targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	battleText = string_ext(_action.description, [_user.name]);
	
	if(!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	
	with(_user)
	{
		acting = true;
		//play user animation if it is defined for that action, and that user
		if(!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
	
	battleState = BattleStatePerformAction;
}

function BattleStatePerformAction()
{
	//if animation etc is still playing
	if(currentUser.acting)
	{
		//when it ends, perform action effect if it exists
		if(currentUser.image_index >= currentUser.image_number -1)
		{
			with(currentUser)
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
			
			if(variable_struct_exists(currentAction, "effectSprite") && variable_struct_exists(currentAction,"effectSound"))
			{
				if(currentAction.effectOnTarget == MODE.ALWAYS) || ((currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1))
				{
					audio_play_sound(currentAction.effectSound, 99, false);
					for(var i = 0; i < array_length(currentTargets); i++)
					{
						instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth-1, oBattleEffect, {sprite_index: currentAction.effectSprite});
					}
					//if(currentAction.effectSound != sndHeal)
					//{
					//	audio_play_sound(sndDamage, 99, false);
					//}
				}
				else //Play it at 0,0
				{
					var _effectSprite = currentAction._effectSprite;
					var _effectSound = currentAction._effectSound;
					if(variable_struct_exists(currentAction, "effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget;
					audio_play_sound(_effectSound, 99, false);
					instance_create_depth(x, y, depth-100, oBattleEffect, {sprite_index: _effectSprite});
					if(instance_exists(oBattleEffect) && _effectSound != sndHeal)
					{
						audio_play_sound(sndDamage, 99, false);
					}
					
				}
			}
			currentAction.func(currentUser, currentTargets);
		}
	}
	else
	{
		if(!instance_exists(oBattleEffect))
		{
			battleWaitTimeRemaining--
			if(battleWaitTimeRemaining == 0)
			{
				battleState = BattleStateVictoryCheck;
			}
		}
	}
}

function BattleStateVictoryCheck()
{
	var win = true;
	
	for(var i = 0; i < array_length(enemyUnits); i++)
	{
		if (enemyUnits[i].hp > 0)
	    {
			win = false;
	    }
	}
	
	if(win)
	{
		battleState = BattleStateWin;
	}
	else
	{
		battleState = BattleStateTurnProgression;
	}
	
}

function BattleStateWin()
{
	var _exp = 0;
	var _expText = "";
	
	if(!array_contains(pages, victoryText))
	{
		array_push(pages, victoryText);
	}
	
	for(var i = 0; i < array_length(enemyUnits); i++)
	{
		_exp += enemyUnits[i].xpValue;
	}
	_expText =  string_ext("You got {0} exp", [_exp])
	
	SetSongInGame(sndWon,0,0);
	
	if(!array_contains(pages, _expText))
	{
		array_push(pages, _expText);
	}
	
	if(pageNum < array_length(pages))
	{
		battleText = pages[pageNum];
		
	}
	else
	{
		for(var i = 0; i < array_length(partyUnits); i++)
		{
			global.party[i].hp = partyUnits[i].hp;
			global.party[i].mp = partyUnits[i].mp;
			UpdateExp(i, _exp);
		}
		
		SetSongInGame(prevSong, 60, 5*60);
		instance_activate_all();
		instance_destroy(creator);
		instance_destroy();
		exit;
	}
	
	if(keyboard_check_pressed(vk_enter))
	{
		pageNum++;
	}
}

function BattleStateTurnProgression()
{
	battleText = "";
	turnCount++;
	turn++;
	//Loop turns
	if(turn > array_length(unitTurnOrder) - 1)
	{
		turn = 0;
		roundCount++;
	}
	
	battleState = BattleStateSelectAction;
}

battleState = BattleStateSelectAction;

