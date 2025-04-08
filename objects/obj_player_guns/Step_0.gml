x = obj_player_functions.x;
y = obj_player_functions.y;
image_angle = obj_player_functions.firing_angle;

/* 
right gun barrel x = gun_barrels[0]
right gun barrel y = gun_barrels[1]
left gun barrel x = gun_barrels[2]
left gun barrel y = gun_barrels[3]
*/
find_gun_create_coordinates(gun_barrels, 25, 65);
right_gun_barrel[0] = gun_barrels[0];
right_gun_barrel[1] = gun_barrels[1];
left_gun_barrel[0]  = gun_barrels[2];
left_gun_barrel[1]  = gun_barrels[3];

player_gun_timer -= obj_global_timer.delta;

if (player_gun_timer < 0) player_gun_timer = 0;


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
	image_speed = 1;
}
else
{
	image_speed = 0;
}

if (firing and player_gun_timer == 0)
{
	muzzle_flash();
	eject_shells();
	shoot_bullets();
	
	player_gun_timer = player_gun_cooldown;
}
