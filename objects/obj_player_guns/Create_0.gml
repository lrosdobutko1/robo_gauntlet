
image_scale = obj_player_legs.image_scale;
image_xscale = image_scale;
image_yscale = image_scale;
image_index = 0;
image_speed = 0;

player_gun_cooldown = 80;
gun_type = [
0,		//machinegun
1,		//shotgun
2,		//grenade
3,		//blaster
];

bullet_type = gun_type[0];

firing = false;
firing_angle = image_angle;
firing_offset = 0;

player_gun_timer = player_gun_cooldown;

gun_barrels = array_create(4);
left_gun_barrel = array_create(2);
right_gun_barrel = array_create(2);

/* 
right gun barrel x = gun_barrels[0]
right gun barrel y = gun_barrels[1]
left gun barrel x = gun_barrels[2]
left gun barrel y = gun_barrels[3]
*/
find_gun_create_coordinates(gun_barrels, 25, 65);

right_gun_barrel[0] = gun_barrels[0];
right_gun_barrel[1] = gun_barrels[1];
left_gun_barrel[0] = gun_barrels[2];
left_gun_barrel[1] = gun_barrels[3];

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


function muzzle_flash( 
_layer,
right_barrel_x,
right_barrel_y,
left_barrel_x,
left_barrel_y
)
{
	var creator = id;
	//right gun
	var right_muzzle_flash = instance_create_layer(
	right_barrel_x,
	right_barrel_y,
	_layer,
	obj_player_muzzle_flash)
	{
		right_muzzle_flash.image_angle = image_angle;	
		right_muzzle_flash.x = right_barrel_x;
		right_muzzle_flash.y = right_barrel_y;
		right_muzzle_flash.gun_parent = creator; // Store gun reference
		right_muzzle_flash.is_left = false;
	}

	//left gun
	var left_muzzle_flash = instance_create_layer(left_barrel_x,
	left_barrel_y,
	_layer,
	obj_player_muzzle_flash)
	{
		left_muzzle_flash.image_angle = image_angle;	
		left_muzzle_flash.x = left_barrel_x;
		left_muzzle_flash.y = left_barrel_y;
		left_muzzle_flash.gun_parent = creator; // Store gun reference
		left_muzzle_flash.is_left = true;
	}
}


function eject_shells( 
_layer,
right_barrel_x,
right_barrel_y,
left_barrel_x,
left_barrel_y
)
{
	
	coords_create_shell_casings = find_gun_create_coordinates(coords,8,45);
	//eject casings
	with(instance_create_layer(
	coords_create_shell_casings[0],
	coords_create_shell_casings[1],
	_layer,
	obj_bullet_casing))
	{
		direction = other.image_angle+random_range(-15,15);
		image_angle = direction;
	}
	
	with(instance_create_layer(
	coords_create_shell_casings[2],
	coords_create_shell_casings[3],
	_layer,
	obj_bullet_casing)
	)
	{
		direction = other.image_angle-180+random_range(-15,15);
		image_angle = direction;
	}
}


function shoot_rockets()
{

	
	
}


