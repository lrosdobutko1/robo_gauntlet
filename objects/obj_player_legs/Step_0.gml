
//moving
moving = false;

h_speed = obj_player_collision.h_speed * global.delta_multiplier;
v_speed = obj_player_collision.v_speed * global.delta_multiplier;

var next_x = x + obj_player_collision.h_speed;
var next_y = y + obj_player_collision.v_speed;

var angle_diff = angle_difference(image_angle, point_direction(x,y,next_x,next_y)-90);

//animate legs
if (h_speed != 0 || v_speed != 0)
{
	moving = true;
}
else 
{
	moving = false;
}

if (moving == true)
{
	image_speed = 1;
	image_angle -= min(abs(angle_diff), 5) * sign(angle_diff);

}
else
{
	image_speed = 0;
}

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

if (firing and player_gun_timer == 0)
{
	muzzle_flash();
	eject_shells();
	shoot_bullets();
	
	player_gun_timer = player_gun_cooldown;
}

if (firing)
{
	get_sight_line(gun_barrels[0],gun_barrels[1],rotation_angle,obj_obstacle);
	get_sight_line(gun_barrels[2],gun_barrels[3],rotation_angle+90,obj_obstacle);
}