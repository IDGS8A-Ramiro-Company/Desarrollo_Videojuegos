//Action Library
global.actionLibrary = 
{
	attack:
	{
		name: "Attack",
		description: "{0} attacks!",
		subMenu: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "attack",
		effectSprite: sAttackSlash,
		effectSound: sndDamage,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				if(array_length (_targets) > 1) _damage = ceil(_damage * 0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
		}
	},
	defend:
	{
		name: "Defend",
		description: "{0} defends!",
		subMenu: -1,
		targetRequired: false,
		targetEnemyByDefault: false,
		targetAll: MODE.NEVER,
		userAnimation: "defend",
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				if(array_length (_targets) > 1) _damage = ceil(_damage * 0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
		}
	},
	tackle:
	{
		name: "Tackle",
		description: "{0} attacks!",
		subMenu: -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation: "attack",
		effectSprite: sAttackBonk,
		effectSound: sndTackle,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				if(array_length (_targets) > 1) _damage = ceil(_damage * 0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
		}
	},
	ice:
	{
		name: "Ice",
		description: "{0} casts Ice!",
		subMenu: "Magic",
		mpCost: 4,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation: "cast",
		effectSprite: sAttackIce,
		effectSound: sndIce,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(10,15);
				if(array_length (_targets) > 1) _damage = ceil(_damage * 0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	fire:
	{
		name: "Fire",
		description: "{0} casts Fire!",
		subMenu: "Magic",
		mpCost: 4,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation: "cast",
		effectSprite: sAttackFire,
		effectSound: sndFire,
		effectOnTarget: MODE.ALWAYS,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(15,20);
				if(array_length (_targets) > 1) _damage = ceil(_damage * 0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	heal:
	{
		name: "Heal",
		description: "{0} casts Heal!",
		subMenu: "Magic",
		mpCost: 3,
		targetRequired: true,
		targetEnemyByDefault: false,
		targetAll: MODE.NEVER,
		userAnimation: "cast",
		effectSprite: sAttackHeal,
		effectSound: sndHeal,
		effectOnTarget: MODE.ALWAYS,
		stateOfTarget: TARGET.EITHER,
		func: function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(15,20);
				if(array_length (_targets) > 1) _damage = ceil(_damage * 0.75);
				BattleChangeHP(_targets[i], _damage, stateOfTarget);
			}
			BattleChangeMP(_user, -mpCost)
		}
	}
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

enum TARGET
{
	ALIVE = 0,
	DEAD = 1,
	EITHER = 2
}

enum DIALOGTYPE
{
	NORMAL = 1,
	STORY = 2,
	CREDITS = 3
}

//Party data
global.party = 
[
	{
		name: "Lulu",
		hp: 89,
		hpMax: 89,
		mp: 10,
		mpMax: 15,
		strength: 6,
		experience: 0,
		maxExp: 10,
		lvl: 1,
		sprites : { idle: sLuluIdle, attack: sLuluAttack, defend: sLuluDefend, down: sLuluDown},
		actions : [global.actionLibrary.attack]
	}
	,
	{
		name: "Questy",
		hp: 18,
		hpMax: 44,
		mp: 20,
		mpMax: 30,
		strength: 4,
		experience: 0,
		maxExp: 10,
		lvl: 1,
		sprites : { idle: sQuestyIdle, attack: sQuestyCast, cast: sQuestyCast, down: sQuestyDown},
		actions : [global.actionLibrary.attack, global.actionLibrary.fire]
	}
]

//Enemy Data
global.enemies =
{
	slimeG: 
	{
		name: "Slime",
		hp: 30,
		hpMax: 30,
		mp: 0,
		mpMax: 0,
		strength: 5,
		sprites: { idle: sSlime, attack: sSlimeAttack},
		actions: [global.actionLibrary.tackle],
		xpValue : 15,
		AIscript : function()
		{
			//enemy turn ai goes here
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	bat: 
	{
		name: "Bat",
		hp: 15,
		hpMax: 15,
		mp: 0,
		mpMax: 0,
		strength: 4,
		sprites: { idle: sBat, attack: sBatAttack},
		actions: [global.actionLibrary.attack],
		xpValue : 18,
		AIscript : function()
		{
			//enemy turn ai goes here
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
}

global.levelUps =
[

	{
		name: "Lulu",
		strength: 8,
		levels:
		[
			{
				level: 2,
				action: global.actionLibrary.heal
			}
		]
	}
	,
	{
		name: "Questy",
		strength: 2,
		levels:
		[
			{
				level: 2,
				action: global.actionLibrary.ice
			}
		]
	}
]



