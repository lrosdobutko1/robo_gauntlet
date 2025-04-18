life_timer --;
image_yscale = image_scale;
image_xscale = image_scale;

switch (gun_type)
{
	case 1:
	{
		choose_sprite_index = gun_type;
		break;
	}
	
		case 2:
	{
		choose_sprite_index = gun_type;
		break;
	}
	
		case 3:
	{
		choose_sprite_index = gun_type;
		break;
	}
	
		case 4:
	{
		choose_sprite_index = gun_type;
		break;
	}	
				
	case 5:
	{
		choose_sprite_index = gun_type;	
		break;
	}
	
	case 6:
	{
		choose_sprite_index = gun_type;	
		image_scale += 0.07;
		if (image_scale >= 1) image_scale = 1;
		break;
	}
}

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

//collision with walls
if (created)
{
	wall_collision = get_bullet_sight_line(x,y, direction_angle, obj_obstacle);
	end_x = wall_collision[0];
	end_y = wall_collision[1];
}
created = false;

if (abs(x - end_x) < speed && abs(y - end_y) < speed)
{
    instance_destroy();
}

if (distance_to_point(end_x, end_y) <= speed)
{
	move_towards_point(end_x,end_y, speed);
}

//show_debug_message(gun_type);




