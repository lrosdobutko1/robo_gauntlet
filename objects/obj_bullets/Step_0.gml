life_timer --;

if (life_timer <= 0 )
{
	instance_destroy();
}

var wall_collision = get_sight_line(x,y,image_angle+90,obj_obstacle);
if (wall_collision - sprite_get_height(spr_player_bullets) - speed <= 0) instance_destroy();