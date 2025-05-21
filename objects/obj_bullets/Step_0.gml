life_timer --;
image_yscale = image_scale;
image_xscale = image_scale;


//bullets created by player
if (creator == obj_player_functions.id)
{
	switch (gun_type)
	{
		case 1:
		{
			bullet_speed = 7;
			choose_sprite_index = gun_type;
			collision_offset = 8;
			bounding_box_size_h = 24;
			bounding_box_size_v = 2;
			break;
		}
	
			case 2:
		{
			bullet_speed = 7;
			choose_sprite_index = gun_type;
			bounding_box_size_h = 13;
			bounding_box_size_v = 4;
			break;
		}
	
			case 3:
		{
			if (created)
			{
				bullet_speed = 1.5;
				created = false;
			}
			bullet_speed += 0.05;
			if (bullet_speed >= 7) bullet_speed = 7;
			choose_sprite_index = gun_type;
			collision_offset = 8;
			bounding_box_size_h = 14;
			bounding_box_size_v = 4;			
			break;
		}
	
			case 4:
		{
			bullet_speed = 7;
			choose_sprite_index = gun_type;
			collision_offset = 8;
			break;
		}	
				
		case 5:
		{
			bullet_speed = 7;
			choose_sprite_index = gun_type;	
			collision_offset = 8;
			bounding_box_size_h = 22;
			bounding_box_size_v = 4;
			break;
		}
	
		case 6:
		{
			bullet_speed = 7;
			frame_skip ++;
			if (frame_skip >=3) 
			{
				if (choose_sprite_index != sprite_get_number(spr_bullets_1)-1)
				choose_sprite_index ++ ;
				frame_skip = 0;
			}
	
			collision_offset = -4;
			
			bounding_box_size_h = 9;
			bounding_box_size_v = 9;
			break;
		}
	}

}

//bullets created by enemies
else
{
	choose_sprite_index = 1;

	bullet_speed = 6;
	bounding_box_size_h = 24;
	bounding_box_size_v = 2;
	damage_to_player = 2;
}

if (
life_timer <= 0 ||
collision_box_size(x, y, creator, bounding_box_size_h, bounding_box_size_v, obj_obstacle) || 
collision_box_size(x, y, creator, bounding_box_size_h, bounding_box_size_v, obj_entities)
)
 
{
	instance_destroy();
	//obj_entities.hp -= damage;
}

speed = bullet_speed * global.delta_multiplier;

//collision with walls using ray-casting
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

//collision with walls using custom bounding box
