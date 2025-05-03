life_timer --;
image_yscale = image_scale;
image_xscale = image_scale;


//bullets created by player
if (creator == obj_player_functions.id)
{
	bullet_speed = 8;
	switch (gun_type)
	{
		case 1:
		{
			choose_sprite_index = gun_type;
			collision_offset = 8;
			break;
		}
	
			case 2:
		{
			choose_sprite_index = gun_type;
			collision_offset = -4;
			break;
		}
	
			case 3:
		{
			choose_sprite_index = gun_type;
			collision_offset = 8;
			break;
		}
	
			case 4:
		{
			choose_sprite_index = gun_type;
			collision_offset = 8;
			break;
		}	
				
		case 5:
		{
			choose_sprite_index = gun_type;	
			collision_offset = 8;
			break;
		}
	
		case 6:
		{
			choose_sprite_index = gun_type;	
			collision_offset = -4;
			image_scale += 0.07;
			if (image_scale >= 1) image_scale = 1;
			break;
		}
	}

}

//bullets created by enemies
else
{
	choose_sprite_index = 1;

	bullet_speed = 6;
	damage_to_player = 2;
	show_debug_message("I am not a player bullet.")
}


if (life_timer <= 0 )
{
	instance_destroy();
}

speed = bullet_speed * global.delta_multiplier + random_range(-2,2);

//collision with walls
//if (created)
//{
//	wall_collision = get_bullet_sight_line(x,y, direction_angle, obj_obstacle, collision_offset);
//	end_x = wall_collision[0];
//	end_y = wall_collision[1];
//}
//created = false;

//if (abs(x - end_x) < speed && abs(y - end_y) < speed)
//{
//    instance_destroy();
//}

//if (distance_to_point(end_x, end_y) <= speed)
//{
//	move_towards_point(end_x, end_y, speed);
//}

//show_debug_message(gun_type);


