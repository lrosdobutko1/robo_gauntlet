life_timer --;

//if (gun_type == PLAYER_GUN_TYPE.MACHINEGUN)
//{
//	sprite = spr_bullets;	
//}
//else if (gun_type == PLAYER_GUN_TYPE.BLASTER)
//{
//	image_yscale = image_scale * 4;
//	sprite = spr_laser;
//}

if (life_timer <= 0 )
{
	instance_destroy();
}

var wall_collision = get_bullet_sight_line(x,y,image_angle+90,obj_obstacle);
if (wall_collision - sprite_get_height(spr_bullets)*4 - speed <= 0) instance_destroy();

show_debug_message(gun_type);