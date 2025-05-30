
//moving






x = obj_player_collision.x;
y = obj_player_collision.y;

var nearest_enemy = instance_nearest(x,y,obj_enemy_1);

//shooting

/* 
right gun barrel x = gun_barrels[0]
right gun barrel y = gun_barrels[1]
left gun barrel x = gun_barrels[2]
left gun barrel y = gun_barrels[3]
*/


var prev_gun = gun_select_keys; // Store previous selection

// Check for key press
if (keyboard_check_pressed(ord("1")))		gun_select_keys = 1;
else if (keyboard_check_pressed(ord("2")))	gun_select_keys = 2;
else if (keyboard_check_pressed(ord("3")))	gun_select_keys = 3;
else if (keyboard_check_pressed(ord("4")))	gun_select_keys = 4;
else if (keyboard_check_pressed(ord("5")))	gun_select_keys = 5;
else if (keyboard_check_pressed(ord("6")))	gun_select_keys = 6;

// Only show debug if it actually changed
if (gun_select_keys != prev_gun) {
    switch (gun_select_keys)
    {
        case 1: 
		{
			player_gun_type = PLAYER_GUN_TYPE.MACHINEGUN;
			firing_speed_cooldown = 40;
			firing_offset = firing_speed_cooldown * 0.50;
			no_of_bullets = 1;
			firing_angle_offset = 0;
			//damage = player_gun_type;
			
			break;
		}
		
        case 2: 
		{
			player_gun_type = PLAYER_GUN_TYPE.SHOTGUN;
			firing_speed_cooldown = 120;
			no_of_bullets = 3;
			firing_angle_offset = 9;
			damage = player_gun_type;
			break;
		}
		
		case 3: 
		{
			player_gun_type = PLAYER_GUN_TYPE.GRENADE;
			firing_speed_cooldown = 280;
			firing_offset = firing_speed_cooldown * 0.50;
			no_of_bullets = 1;
			firing_angle_offset = 0;
			damage = player_gun_type;
			break;
		}
		
		case 4: 
		{
			player_gun_type = PLAYER_GUN_TYPE.LASER;

			
			
			firing_angle_offset = 0;
			break;
		}
		
		case 5: 
		{
			player_gun_type = PLAYER_GUN_TYPE.BLASTER;
			gun_index = 5;
			firing_speed_cooldown = 30;
			no_of_bullets = 1;
			firing_angle_offset = 0;
			damage = player_gun_type;
			break;
		}
		
		case 6: 
		{
			player_gun_type = PLAYER_GUN_TYPE.FLAMER;
			gun_index = 8;
			firing_speed_cooldown = 4;
			no_of_bullets = 1;
			firing_angle_offset = 0;
			damage = player_gun_type/20;
			break;
		}
    }
}


//fire primary
if (mouse_check_button(1))
{
	firing = true;
}
else
{
	firing = false;
}

///fire secondary
if (mouse_check_button(2) && rockets_ready)
{
	firing_rockets = true;
	rockets_ready = false;
}

if(firing_rockets) 
{
	shoot_rockets(rocket_offset);
	rocket_offset --;
	player_rocket_timer -= obj_global_timer.delta;
	if rocket_offset <= 0 firing_rockets = false;
}
else
{
	rocket_offset = rocket_offset_cd;
	if (!rockets_ready) player_rocket_timer -= obj_global_timer.delta;
	if (player_rocket_timer <= 0)
	{
		rockets_ready = true;
		player_rocket_timer = player_rocket_cooldown;
	}
}



if (firing)
{
	shoot_player_bullets(gun_barrels, firing_speed, firing_offset, player_gun_type, firing_angle_offset, no_of_bullets, damage);
	firing_speed --;
	

	if (player_gun_type == PLAYER_GUN_TYPE.MACHINEGUN)
	{
		gun_index += 0.33;
		if (gun_index >= 4) gun_index = 0;
	}
	else if (player_gun_type == PLAYER_GUN_TYPE.BLASTER) 
	{
		gun_index += 0.15;
		if (gun_index >= (sprite_get_number(spr_player_guns) - 1)) gun_index = 5;
	}
}

if(firing_speed != firing_speed_cooldown)
{
	firing_speed --;
	if (firing_speed <= 0) firing_speed = firing_speed_cooldown;
}
