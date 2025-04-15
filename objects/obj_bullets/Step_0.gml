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

counter ++;
if (counter % 60 == 0)
show_debug_message("bullet: " + string(round(x)) + " " + string(round(y)));
