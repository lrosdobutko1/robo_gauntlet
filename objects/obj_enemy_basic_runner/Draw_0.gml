// Inherit the parent event
event_inherited();

if (health_state != ENEMY_HEALTH_STATE.DEAD && health_state != ENEMY_HEALTH_STATE.DESTROYED)
{
	draw_sprite_ext(legs, leg_anim, x, y, image_scale, image_scale, legs_angle, sprite_color, 1);
	//draw the torso
	draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
	
	if (flash > 0)
	{
		flash --;
		shader_set(sdr_white_flash);
		draw_self();
		draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
		shader_reset();
	}
}

else if (health_state == ENEMY_HEALTH_STATE.DEAD)
{
	draw_sprite_ext(explode_sprite,explode_anim,x,y,3,3,random_range(0,359),c_white,1)
	explode_anim += 0.66;
}


if (path_exists(path))
draw_path(path,x,y,true);
	
draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);


//temp health bars
var x1 = x - 25;
var y1 = y - 30;
var x2 = x1 + max(0,(50 * (current_hp/starting_hp)));
var y2 = y1;

draw_line_width(x1, y1, x2, y2, 10);

//draw a line pointing directly away from the player for knock-back purposes
var _dir = point_direction(x,y, player.x,player.y)-180;
var _knock_back_magnitude = 4;
var _kbx = lengthdir_x(_knock_back_magnitude, _dir);
var _kby = lengthdir_y(_knock_back_magnitude, _dir);

draw_line(x, y, x + _kbx, y + _kby);