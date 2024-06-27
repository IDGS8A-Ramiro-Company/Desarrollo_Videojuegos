//Draw background
draw_sprite(battleBackground,0,x,y);

//Draw units
var _unitWithCurrnetTurn = unitTurnOrder[turn].id;
for (var i = 0; i < array_length(unitRenderOrder); i++)
{
	with (unitRenderOrder[i])
	{
		draw_self();
	}
}

//Draw UI
draw_sprite_stretched(sBox,0,x+75,y+120,245,60);
draw_sprite_stretched(sBox,0,x,y+120,74,60);

//Positions
#macro COLUMN_ENEMY 15
#macro COLUMN_NAME 90
#macro COLUMN_HP 160
#macro COLUMN_MP 220

//Draw headings
draw_set_font(fnM3x6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
draw_text(x+COLUMN_ENEMY, y+120, "ENEMY");
draw_text(x+COLUMN_NAME, y+120, "NAME");
draw_text(x+COLUMN_HP, y+120, "HP");
draw_text(x+COLUMN_MP, y+120, "MP");

//Draw enemy names
draw_set_font(fnOpenSansPX);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _drawLimit = 3;
var _drawn = 0;
for (var i = 0; (i < array_length(enemyUnits)) && (_drawn < _drawLimit); i++)
{
	var _enemyChar = enemyUnits[i];
	if (_enemyChar.hp > 0)
	{
		_drawn++;
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		if(_enemyChar.id == _unitWithCurrnetTurn) draw_set_color(c_yellow);
		draw_text(x+COLUMN_ENEMY, y+130+(i*12), _enemyChar.name);
	}
}

for(var i = 0; i < array_length(partyUnits); i++)
{
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	var _partyChar = partyUnits[i];
	if(_partyChar.id == _unitWithCurrnetTurn) draw_set_color(c_yellow);
	if(_partyChar.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_NAME, y+130+(i*12), _partyChar.name);
	draw_set_halign(fa_right);
	
	draw_set_color(c_white);
	if(_partyChar.hp < (_partyChar.hpMax * 0.5)) draw_set_color(c_orange);
	if(_partyChar.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_HP+50, y+130+(i*12), string(_partyChar.hp) + "/" + string(_partyChar.hpMax));
	
	draw_set_color(c_white);
	if(_partyChar.mp < (_partyChar.mpMax * 0.5)) draw_set_color(c_orange);
	if(_partyChar.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_MP+50, y+130+(i*12), string(_partyChar.mp) + "/" + string(_partyChar.mpMax));
	
	draw_set_color(c_white);
}