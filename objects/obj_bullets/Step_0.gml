//life_timer --;
//image_yscale = image_scale;
//image_xscale = image_scale;


//bullets created by player
//if (life_timer <= 0) instance_destroy();

//var hit = collision_box_size(x, y, creator, bounding_box_size_h, bounding_box_size_v, obj_entities);

//if (hit != noone) 
//{
//	if (hit != creator) 
//	{
//		hit.current_hp -= damage;
//		if variable_instance_exists(hit.id,"flash")
//		{
//			hit.flash = 2;
//		}
//	}
	
//	if (gun_type != 6) instance_destroy();
//}

//wall collision
//var hit_wall = collision_box_size(x, y, creator, bounding_box_size_h, bounding_box_size_v, obj_obstacle);
//if (hit_wall !=noone)
//{
//	instance_destroy();
//}

//speed = bullet_speed * global.delta_multiplier;

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
