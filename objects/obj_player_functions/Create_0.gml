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
};

player_gun_type = PLAYER_GUN_TYPE.MACHINEGUN;

gun_counter = 0;
gun_index = 0;

player_rocket_cooldown = 600;

gun_select_keys = 0;

firing = false;
firing_rockets = false;
firing_angle = image_angle;


//offset for firing left and right guns
gun_offset_counter = 0;
shell_offset_counter = 0;
muzzle_offset_counter = 0;
fire_gun_offset = 20; 

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


//function shoot_player_bullets()
//{
//	find_gun_create_coordinates(gun_barrels,25,65)
	
//	var creator = id;
	
//	//right gun
//	var right_bullets = instance_create_layer(
//	gun_barrels[0],
//	gun_barrels[1],
//	layer,
//	obj_bullets)
//	{
//		right_bullets.image_angle = rotation_angle;	
//		right_bullets.direction = right_bullets.image_angle+90;
//		right_bullets.gun_parent = creator; // Store gun reference
//		right_bullets.is_left = false;
//	}	
	
//	//left gun
//	var left_bullets = instance_create_layer(
//	gun_barrels[2],
//	gun_barrels[3],
//	layer,
//	obj_bullets)
//	{
//		left_bullets.image_angle = rotation_angle;	
//		left_bullets.direction = right_bullets.image_angle+90;
//		left_bullets.x = gun_barrels[2];
//		left_bullets.y = gun_barrels[3];
//		left_bullets.gun_parent = creator; // Store gun reference
//		left_bullets.is_left = true;
//	}
//}

function muzzle_flash(offset)
{
	find_gun_create_coordinates(gun_barrels,25,65)
	var creator = id;
	
	if (muzzle_offset_counter == 0)
    {
		//right gun
		var right_muzzle_flash = instance_create_layer(
		gun_barrels[0],
		gun_barrels[1],
		layer,
		obj_player_muzzle_flash)
		{
			right_muzzle_flash.image_angle = rotation_angle;	
			right_muzzle_flash.x = gun_barrels[0];
			right_muzzle_flash.y = gun_barrels[1];
			right_muzzle_flash.gun_parent = creator; // Store gun reference
			right_muzzle_flash.is_left = false;
		}
		muzzle_offset_counter = offset; // Start countdown
    }
	
	else if (muzzle_offset_counter == offset div 2) // 20 steps after "Tick"
    {
		//left gun
		var left_muzzle_flash = instance_create_layer(
		gun_barrels[2],
		gun_barrels[3],
		layer,
		obj_player_muzzle_flash)
		{
			left_muzzle_flash.image_angle = rotation_angle;	
			left_muzzle_flash.x = gun_barrels[2];
			left_muzzle_flash.y = gun_barrels[3];
			left_muzzle_flash.gun_parent = creator; // Store gun reference
			left_muzzle_flash.is_left = true;
		}
	
	}

    muzzle_offset_counter -= 1;
    if (shell_offset_counter < 0)
    {
        shell_offset_counter = offset; // Reset countdown
    }
}


function eject_shells(offset)
{
	
	find_gun_create_coordinates(casings_eject,12,125)
	
	if (shell_offset_counter == 0)
    {
		//eject casings
		var right_casing = instance_create_layer(
		casings_eject[0],
		casings_eject[1],
		layer,
		obj_bullet_casing)
		{
			right_casing.direction = rotation_angle+random_range(-15,15);
			right_casing.image_angle = direction;
		}
	
		shell_offset_counter = offset; // Start countdown
    }
	else if (shell_offset_counter == offset div 2) // 20 steps after "Tick"
    {
		
		var left_casing = instance_create_layer(
		casings_eject[2],
		casings_eject[3],
		layer,
		obj_bullet_casing)
		{
			left_casing.direction = rotation_angle+random_range(-15,15)-180;
			left_casing.image_angle = direction;
		}
	
	}

    shell_offset_counter -= 1;
    if (shell_offset_counter < 0)
    {
        shell_offset_counter = offset; // Reset countdown
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
			right_rockets.image_angle = rotation_angle+90;
			right_rockets.direction = rotation_angle+(random_range(-15,15));
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
			left_rockets.image_angle = rotation_angle+90;
			left_rockets.direction = rotation_angle-180+(random_range(-15,15));
		}	
	}
}


function get_sight_line(x_start, y_start, angle, target_object) {
    var max_distance = 10000; // Large value to simulate infinity
    var step_size = 1;        // How fine the collision check is
    
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
    draw_line(x_start,y_start,x_end,y_end);
	return line_length;
}


function shoot_player_bullets(offset, player_gun_type)
{
	find_gun_create_coordinates(gun_barrels,25,65)
	var creator = id;
	
    if (gun_offset_counter == 0)
    {
		var right_bullets = instance_create_layer(
		gun_barrels[0],
		gun_barrels[1],
		layer,
		obj_bullets)
		{
			right_bullets.gun_type = player_gun_type;
			right_bullets.image_angle = rotation_angle;	
			right_bullets.direction = right_bullets.image_angle+90;
			right_bullets.x = gun_barrels[0];
			right_bullets.y = gun_barrels[1];
			right_bullets.gun_parent = creator; // Store gun reference
			right_bullets.is_left = false;
			right_bullets.image_speed = 0;
			//switch (right_bullets.gun_type)
			//{
			//	case 1:
			//	{
			//		right_bullets.choose_sprite_index = right_bullets.gun_type;;
			//		show_debug_message("index 0");
			//		break;
			//	}
				
			//	case 5:
			//	{
			//		right_bullets.choose_sprite_index = right_bullets.gun_type;	
			//		show_debug_message("index 5");
			//		break;
			//	}
			//}
		}
        gun_offset_counter = offset; // Start countdown
    }
    else if (gun_offset_counter == offset div 2) // 20 steps after "Tick"
    {
		
		var left_bullets = instance_create_layer(
		gun_barrels[2],
		gun_barrels[3],
		layer,
		obj_bullets)
		{
			left_bullets.gun_type = player_gun_type;
			left_bullets.image_angle = rotation_angle;	
			left_bullets.direction = left_bullets.image_angle+90;
			left_bullets.x = gun_barrels[2];
			left_bullets.y = gun_barrels[3];
			left_bullets.gun_parent = creator;
			left_bullets.is_left = true;
			left_bullets.image_speed = 0;
			//switch (left_bullets.gun_type)
			//{
			//	case 1:
			//	{
			//		left_bullets.choose_sprite_index = left_bullets.gun_type;
			//		break;
			//	}
				
			//	case 5:
			//	{
			//		left_bullets.choose_sprite_index = left_bullets.gun_type;	
			//		break;
			//	}
			//}
		}
    }

    gun_offset_counter -= 1;
    if (gun_offset_counter < 0)
    {
        gun_offset_counter = offset; // Reset countdown
    }
}

