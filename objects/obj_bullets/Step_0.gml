life_timer --;

//if the bullet is created by an enemy
if (gun_parent != obj_player_functions.id) 
{
	bullet_speed = 8;
	damage_to_player = 2;
}
else bullet_speed = 8;

speed = bullet_speed * global.delta_multiplier;

if (life_timer <= 0 )
{
	instance_destroy();
}

var wall_collision = get_bullet_sight_line(x,y,image_angle+90,obj_obstacle);
if (wall_collision - sprite_get_height(spr_bullets)*2 - speed <= 0) instance_destroy();

//show_debug_message(object_get_name(gun_parent.object_index));
//show_debug_message(gun_type);
//show_debug_message(image_index);


switch (gun_type)
{
	case 1:
	{
		choose_sprite_index = gun_type;
		break;
	}
				
	case 5:
	{
		choose_sprite_index = gun_type;	
		break;
	}
}
