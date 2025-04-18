image_scale = 1;

image_speed = 1;
image_xscale = image_scale;
image_yscale = image_scale;

rotation_angle = point_direction(x,y,mouse_x,mouse_y);

//tile_map = layer_tilemap_get_id("level_tiles");

//key_left = false;
//key_right = false;
//key_up = false;
//key_down = false;
moving = false;

h_speed = 0;
v_speed = 0;

walk_speed = 2;

x = obj_player_collision.x;
y = obj_player_collision.y;

enum PLAYER_GUN_TYPE 
{
	NONE,
	MACHINEGUN,
	SHOTGUN,
	GRENADE,
	LASER,
	BLASTER,	
	FLAMER,
};

player_gun_type = PLAYER_GUN_TYPE.MACHINEGUN;

gun_counter = 0;
gun_index = 0;

player_rocket_cooldown = 600;

gun_select_keys = 0;

firing = false;
firing_rockets = false;
firing_angle = image_angle;

firing_speed_cooldown = 40;
firing_speed = firing_speed_cooldown;
firing_offset = firing_speed*0.5;
firing_angle_offset = 2.5;
no_of_bullets = 1;
angle_offset = 0;

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
			right_rockets.image_angle = rotation_angle;
			right_rockets.direction = rotation_angle-90+(random_range(-15,15));
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
			left_rockets.image_angle = rotation_angle;
			left_rockets.direction = rotation_angle+90+(random_range(-15,15));
		}	
	}
}


function get_sight_line(x_start, y_start, angle, target_object) {
    var max_distance = 800; // Large value to simulate infinity
    var step_size = 2;        // How fine the collision check is
    
    var x_end = x_start;
    var y_end = y_start;
	var line_length = max_distance;
    
    for (var i = 0; i < max_distance; i += step_size) {
        x_end = x_start + lengthdir_x(i, angle);
        y_end = y_start + lengthdir_y(i, angle);
        
        // Pixel-perfect collision check
        if (position_meeting(x_end, y_end, target_object)) {
			line_length = i;
            break; // Stop when collision is detected
        }
    }
    return [x_end, y_end];
	//return line_length;
}


function eject_shells(x_coord, y_coord, angle_offset)
{
		//eject casings
		var casing = instance_create_layer(
		x_coord,
		y_coord,
		layer,
		obj_bullet_casing)
		{
			casing.direction = angle_offset + random_range(-15,15);
			casing.image_angle = direction;
		}
}


function create_bullet(creator, x_coord, y_coord, firing_angle_offset)
{
	var bullets = instance_create_layer(
	x_coord,
	y_coord,
	layer,
	obj_bullets)
	{
		bullets.gun_type = player_gun_type;
		bullets.direction_angle = rotation_angle + firing_angle_offset;
		bullets.direction = bullets.direction_angle;
		bullets.image_angle = bullets.direction_angle;
		bullets.x = x_coord;
		bullets.y = y_coord;
		bullets.gun_parent = creator; // Store gun reference
		bullets.is_left = false;
		bullets.image_speed = 0;
		bullets.wall_collision = 0;
		bullets.end_x = 0;
		bullets.end_y = 0;
		if (bullets.gun_type == 6)
		{
			bullets.life_timer = 20;
			bullets.image_scale = 0.1;
			show_debug_message("set bullet scale to really small");
		}
		else 
		{
			bullets.life_timer = 200;
			bullets.image_scale = 1;
			show_debug_message("set bullet scale to normal");
		}
	}	
}

function muzzle_flash()
{
	var creator = id;
	var right_muzzle_flash = instance_create_layer(
		gun_barrels[0],
		gun_barrels[1],
		layer,
		obj_player_muzzle_flash)
		{
			right_muzzle_flash.image_angle = rotation_angle;
			right_muzzle_flash.gun_parent = creator;
			right_muzzle_flash.is_left = false;
		}	
		


		var left_muzzle_flash = instance_create_layer(
		gun_barrels[2],
		gun_barrels[3],
		layer,
		obj_player_muzzle_flash)
		{
			left_muzzle_flash.image_angle = rotation_angle;
			left_muzzle_flash.gun_parent = creator;
			left_muzzle_flash.is_left = true;
		}	
}

function shoot_player_bullets(
gun_barrel_coords, 
firing_speed, 
firing_offset, 
gun_type,
firing_angle_offset,
no_of_bullets
)
{
	find_gun_create_coordinates(gun_barrels, 25, 65);
	find_gun_create_coordinates(casings_eject, 15, 170);
	bullet_loop_create_start = 0 - ((no_of_bullets - 1) / 2)
	var creator = id;
	
	if (player_gun_type != PLAYER_GUN_TYPE.SHOTGUN) muzzle_flash();
	if(firing_speed == firing_speed_cooldown)
	{
		eject_shells(casings_eject[0], casings_eject[1], rotation_angle-90);
		if(player_gun_type == PLAYER_GUN_TYPE.SHOTGUN || 
		player_gun_type == PLAYER_GUN_TYPE.BLASTER ||
		player_gun_type == PLAYER_GUN_TYPE.FLAMER)
		eject_shells(casings_eject[2], casings_eject[3], rotation_angle+90);
		for (var i = bullet_loop_create_start; i < bullet_loop_create_start + no_of_bullets; i++)
		{
			create_bullet(creator, gun_barrel_coords[0], gun_barrel_coords[1], firing_angle_offset*i);

			if (player_gun_type == PLAYER_GUN_TYPE.SHOTGUN || 
			player_gun_type == PLAYER_GUN_TYPE.BLASTER ||
			player_gun_type == PLAYER_GUN_TYPE.FLAMER)
			{
				muzzle_flash()
				create_bullet(creator, gun_barrel_coords[2], gun_barrel_coords[3], firing_angle_offset*i);
			}
		}

	}
	else if(firing_speed == firing_offset)
	{
		if (player_gun_type != PLAYER_GUN_TYPE.SHOTGUN && 
		player_gun_type != PLAYER_GUN_TYPE.BLASTER && 
		player_gun_type != PLAYER_GUN_TYPE.FLAMER)
		{
			eject_shells(casings_eject[2], casings_eject[3], rotation_angle+90);
			create_bullet(creator, gun_barrel_coords[2], gun_barrel_coords[3], firing_angle_offset*0);
		}
	}
}

count_cooldown = 120;
count = count_cooldown;

line = get_sight_line(gun_barrels[0],gun_barrels[1], rotation_angle,obj_wall);