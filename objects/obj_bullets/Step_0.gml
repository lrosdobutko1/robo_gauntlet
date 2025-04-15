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

//collision with walls
if (created)
{
	wall_collision = get_bullet_sight_line(x,y, direction_angle, obj_obstacle);
	end_x = wall_collision[0];
	end_y = wall_collision[1];
}
created = false;

if (abs(x - speed - end_x) < speed && abs(y - speed - end_y) < speed)
{
    instance_destroy();
}


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
				
	case 5:
	{
		choose_sprite_index = gun_type;	
		break;
	}
}


