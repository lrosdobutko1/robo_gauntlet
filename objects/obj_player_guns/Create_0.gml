
image_scale = obj_player_legs.image_scale;
image_xscale = image_scale;
image_yscale = image_scale;
image_index = 0;
image_speed = 0;

player_gun_cooldown = 0;
enum GUN_TYPE
{
	NONE,
	BULLET,
	GRENADE,
	MISSILE,
	SHOTGUN,
	LASER,
}

type = GUN_TYPE.LASER;
switch (type)
{
	case GUN_TYPE.BULLET:
		player_gun_cooldown = 80;
		break;
		
	case GUN_TYPE.GRENADE:
		player_gun_cooldown = 500;
		break;
		
	case GUN_TYPE.SHOTGUN:
		player_gun_cooldown = 200;
		break;
		
	case GUN_TYPE.LASER:
		player_gun_cooldown = 100;
		break;
		
	default:
		player_gun_cooldown = 0;
}

firing = false;
firing_angle = image_angle;
firing_offset = 0;


player_gun_timer = player_gun_cooldown;


function ShootBullets(_obj, _layer, )
{
	
	firing_offset ++;

	if (firing_offset > game_get_speed(gamespeed_fps))
	{
		firing_offset = 0;
	}

	//find the coordinates to create bullets at by calculating isoscoles triangle
	var x_fixed = x; // Replace with the actual fixed x-position
	var y_fixed = y; // Replace with the actual fixed y-position

	// Triangle parameters
	var radius = 20 * image_scale; // Distance from the fixed point to the other two points
	var spread_angle = 80; // Spread angle between the two equal points (in degrees)

	// Direction to the mouse
	var angle_to_mouse = point_direction(x_fixed, y_fixed, mouse_x, mouse_y);

	// Calculate the positions of the two equal points
	var angle1 = angle_to_mouse - spread_angle / 2; // First point's angle
	var angle2 = angle_to_mouse + spread_angle / 2; // Second point's angle

	var x1 = x_fixed + lengthdir_x(radius, angle1);
	var y1 = y_fixed + lengthdir_y(radius, angle1);
	var x2 = x_fixed + lengthdir_x(radius, angle2);
	var y2 = y_fixed + lengthdir_y(radius, angle2);
	
	var x1_1 = x_fixed + lengthdir_x(radius/3, angle1-20);
	var y1_1 = y_fixed + lengthdir_y(radius/3, angle1-20);
	var x2_1 = x_fixed + lengthdir_x(radius/3, angle2+20);
	var y2_1 = y_fixed + lengthdir_y(radius/3, angle2+20);

	if (firing_offset % 2 = 0)
	{
		//fire bullets
		with(instance_create_layer(x1,y1,_layer,_obj))
		{
			direction = other.image_angle+90 + random_range(-1,1);
			image_angle = direction-90;
		}
		//eject casings
		with(instance_create_layer(x1_1,y1_1,_layer,obj_bullet_casing))
		{
			direction = other.image_angle+random_range(-15,15);
			image_angle = direction;
		}
		
	}
	else 
	{
		//fire bullets
		with(instance_create_layer(x2,y2,_layer,_obj))
		{

			direction = other.image_angle+90  + random_range(-1,1);
			image_angle = direction-90;
		}
		
		//eject casings
		with(instance_create_layer(x2_1,y2_1,_layer,obj_bullet_casing))
		{
			direction = other.image_angle-180+random_range(-15,15);
			image_angle = direction;
		}
	}
	
}


function EjectCasing(_obj, _layer,)
{
	
	//find the coordinates to create bullets at by calculating isoscoles triangle
	var x_fixed = x; // Replace with the actual fixed x-position
	var y_fixed = y; // Replace with the actual fixed y-position

	// Triangle parameters
	var radius = 20 * image_scale; // Distance from the fixed point to the other two points
	var spread_angle = 80; // Spread angle between the two equal points (in degrees)

	// Direction to the mouse
	var angle_to_mouse = point_direction(x_fixed, y_fixed, mouse_x, mouse_y);

	// Calculate the positions of the two equal points
	var angle1 = angle_to_mouse - spread_angle / 2; // First point's angle
	var angle2 = angle_to_mouse + spread_angle / 2; // Second point's angle

	var x1 = x_fixed + lengthdir_x(radius, angle1);
	var y1 = y_fixed + lengthdir_y(radius, angle1);

	var x2 = x_fixed + lengthdir_x(radius, angle2);
	var y2 = y_fixed + lengthdir_y(radius, angle2);

	if (firing_offset % 2 = 0)
	{
		//fire bullets
		with(instance_create_layer(x1,y1,_layer,_obj))
		{
			speed = obj_player_guns.bullet_speed;
			direction = other.image_angle+90;
			image_angle = direction-90;
		}
	}
	else 
	{
		with(instance_create_layer(x2,y2,_layer,_obj))
		{
			speed = obj_player_guns.bullet_speed;
			direction = other.image_angle+90;
			image_angle = direction-90;
		}
	}
	
	firing_delay = 2;
}

