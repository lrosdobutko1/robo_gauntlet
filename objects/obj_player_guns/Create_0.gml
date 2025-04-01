
image_scale = obj_player_legs.image_scale;
image_xscale = image_scale;
image_yscale = image_scale;
image_index = 0;
image_speed = 0;

player_gun_cooldown = 120;
player_rocket_cooldown = 600;
gun_type = [
0,		//machinegun
1,		//shotgun
2,		//grenade
3,		//blaster
];

bullet_type = gun_type[0];

firing = false;
firing_rockets = false;
firing_angle = image_angle;
firing_offset = 0;
player_gun_timer = player_gun_cooldown;

player_rocket_cooldown = 2400;
player_rocket_timer = player_rocket_cooldown;
rockets_ready = true;

rocket_offset_cd = 60;
rocket_offset = rocket_offset_cd;

gun_barrels = array_create(4);
left_gun_barrel = array_create(2);
right_gun_barrel = array_create(2);

casings_eject = array_create(4);

rocket_launchers = array_create(4);


function find_gun_create_coordinates(coords, radius, spread_angle)
{
	
	//find the coordinates to create bullets at by calculating isoscoles triangle
	var x_fixed = x;
	var y_fixed = y;

	// Triangle parameters
	radius = radius * image_scale; // Distance from the fixed point to the other two points
	spread_angle = spread_angle; // Spread angle between the two equal points (in degrees)

	// Direction to the mouse
	var angle_to_mouse = point_direction(x_fixed, y_fixed, mouse_x, mouse_y);

	// Calculate the positions of the two equal points
	var angle1 = angle_to_mouse - spread_angle / 2; // First point's angle
	var angle2 = angle_to_mouse + spread_angle / 2; // Second point's angle

	coords[0] = x_fixed + lengthdir_x(radius, angle1);
	coords[1] = y_fixed + lengthdir_y(radius, angle1);
	coords[2] = x_fixed + lengthdir_x(radius, angle2);
	coords[3] = y_fixed + lengthdir_y(radius, angle2);
	
}


function shoot_bullets()
{
	find_gun_create_coordinates(gun_barrels,25,65)
	
	var creator = id;
	
	//right gun
	var right_bullets = instance_create_layer(
	gun_barrels[0],
	gun_barrels[1],
	layer,
	obj_bullets)
	{
		right_bullets.image_angle = image_angle;	
		right_bullets.direction = right_bullets.image_angle+90;
		right_bullets.gun_parent = creator; // Store gun reference
		right_bullets.is_left = false;
	}	
	
	//left gun
	var left_bullets = instance_create_layer(
	gun_barrels[2],
	gun_barrels[3],
	layer,
	obj_bullets)
	{
		left_bullets.image_angle = image_angle;	
		left_bullets.direction = right_bullets.image_angle+90;
		left_bullets.x = gun_barrels[2];
		left_bullets.y = gun_barrels[3];
		left_bullets.gun_parent = creator; // Store gun reference
		left_bullets.is_left = true;
	}
}


function muzzle_flash()
{
	find_gun_create_coordinates(gun_barrels,25,65)
	
	var creator = id;
	
	//right gun
	var right_muzzle_flash = instance_create_layer(
	gun_barrels[0],
	gun_barrels[1],
	layer,
	obj_player_muzzle_flash)
	{
		right_muzzle_flash.image_angle = image_angle;	
		right_muzzle_flash.x = gun_barrels[0];
		right_muzzle_flash.y = gun_barrels[1];
		right_muzzle_flash.gun_parent = creator; // Store gun reference
		right_muzzle_flash.is_left = false;
	}

	//left gun
	var left_muzzle_flash = instance_create_layer(
	gun_barrels[2],
	gun_barrels[3],
	layer,
	obj_player_muzzle_flash)
	{
		left_muzzle_flash.image_angle = image_angle;	
		left_muzzle_flash.x = gun_barrels[2];
		left_muzzle_flash.y = gun_barrels[3];
		left_muzzle_flash.gun_parent = creator; // Store gun reference
		left_muzzle_flash.is_left = true;
	}
}

function eject_shells()
{
	
	find_gun_create_coordinates(casings_eject,12,125)
	
	//eject casings
	var right_casing = instance_create_layer(
	casings_eject[0],
	casings_eject[1],
	layer,
	obj_bullet_casing)
	{
		right_casing.direction = image_angle+random_range(-15,15);
		right_casing.image_angle = direction;
	}
	
	var left_casing = instance_create_layer(
	casings_eject[2],
	casings_eject[3],
	layer,
	obj_bullet_casing)
	{
		left_casing.direction = image_angle+random_range(-15,15)-180;
		left_casing.image_angle = direction;
	}
}


function shoot_rockets(rocket_offset)
{
	
	var rocket_cycle_countdown = rocket_offset;


	find_gun_create_coordinates(rocket_launchers,15,210)
	
	var creator = id;
	

	if(rocket_cycle_countdown % 30 == 0)	
	{
		//right rocket
		var right_rockets = instance_create_layer(
		rocket_launchers[0],
		rocket_launchers[1],
		layer,
		obj_player_rockets)
		{
			right_rockets.image_angle = image_angle+90;
			right_rockets.direction = image_angle+(random_range(-15,15));
		
		}	
	}
	else if(rocket_cycle_countdown % 20 == 0)
	{

		//left rocket
		var left_rockets = instance_create_layer(
		rocket_launchers[2],
		rocket_launchers[3],
		layer,
		obj_player_rockets)
		{
			left_rockets.image_angle = image_angle+90;
			left_rockets.direction = image_angle-180+(random_range(-15,15));
		
		}	
	}
	

	
	
}


