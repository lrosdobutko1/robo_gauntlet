
//if (current_bullet_type.bullet_name != "Muzzle Flash") {

//	//if (current_bullet_type.bullet_name == "Rocket") {
//	//	speed -= 0.05;
	
//	//	image_xscale = image_size;
//	//	image_yscale = image_size;

//	//	life_time --;
//	//	activate_timer--;

//	//	if(life_time <= 0)
//	//	{
//	//		alive = false;
//	//	}

//	//	if (activate_timer <= 0) 
//	//	{
//	//		speed = 0;
//	//		active = true;
//	//	}

//	//	if (active)
//	//	{
//	//		image_speed = 1;
//	//		direction = image_angle;
//	//		if (alive)
//	//		speed = 12;
//	//		else speed = 0;
	
//	//		if(alive) instance_create_layer(x,y,layer,obj_rocket_smoke);
//	//		if (instance_exists(obj_enemy_parent))
//	//		{
//	//			target = instance_nearest(x,y, obj_enemy_parent);
//	//			var angle_diff = angle_difference(image_angle, point_direction(x,y,target.x,target.y));
//	//			image_angle -= min(abs(angle_diff), turn_radius) * sign(angle_diff);
//	//			turn_radius += 0.01;
//	//		}
//	//	}
//	//}


//	if (current_bullet_type.bullet_name != "Flamer")
//	{
//	    rotation = 0;
//	}

//	if (life_timer > 0) life_timer --;
//	if (life_timer == 0) instance_destroy();
//	//if (current_bullet_type.bullet_name == "Flamer") rotation++;

//	#region Destroy bullets past the screen edge

//	var px = obj_player_functions.x;
//	var py = obj_player_functions.y;
//	if (abs(x - px) > room_width/2 || abs(y - py) > room_height/2) {
//	    instance_destroy();
//	}

//	#endregion	


//	#region Collision with walls

//	var hit_wall = resolve_x_collision(hspeed, obj_obstacle);

//	if (hit_wall == noone)
//	{
//	    hit_wall = resolve_y_collision(vspeed, obj_obstacle);
//	}


//	if (hit_wall != noone)
//	{

//	    if (current_bullet_type.bullet_name != "Flamer")
//	    {
//	        instance_destroy();
//	    }
//	    else
//	    {
//	        collision_timer--;
//	        if (collision_timer <= 0) instance_destroy();
//	    }
//	}
//	#endregion

//	#region collision with enemies

//	var hit_enemy = resolve_x_collision(hspeed, enemy);

//	if (hit_enemy == noone)
//	{
//	    hit_enemy = resolve_y_collision(vspeed, enemy);
//	}

//	if (hit_enemy != noone)
//	{
	
//	    if (current_bullet_type.bullet_name != "Flamer")
//	    {
//			calculate_damage(hit_enemy, damage)
//	        instance_destroy();
//	    }
//	    else
//	    {
//	        collision_timer--;
//	        if (collision_timer <= 0) instance_destroy();
//	    }
//	}
	
//	if (current_bullet_type.bullet_name == "Shell Casing") {
//		image_index = 0;
//		image_xscale = 0.5;
//		image_yscale = 0.5;
//		speed -= 0.1;
//		if (speed <= 0) speed = 0;
//	}	

//	#endregion
//}

//else if (current_bullet_type.bullet_name == "Muzzle Flash") {
//	if (obj_player_functions.current_primary_weapon.weapon_name != "Blaster")
//	{
//		image_index = irandom_range(0, 7);
//		image_index++;
//		if (image_index > 7) image_index = 0;
//	}
//	else {
//		image_index = irandom_range(8, 10);
//		image_index++;
//		if (image_index > 10) image_index = 8;
//	}
//	if (life_timer > 0) life_timer --;
//	if (life_timer == 0) instance_destroy();
//}






