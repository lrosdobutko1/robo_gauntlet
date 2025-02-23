x = obj_player_torso.x;
y = obj_player_torso.y;
image_angle = obj_player_torso.image_angle;

find_gun_create_coordinates(gun_barrels, 25, 65);
right_gun_barrel[0] = gun_barrels[0];
right_gun_barrel[1] = gun_barrels[1];
left_gun_barrel[0]  = gun_barrels[2];
left_gun_barrel[1]  = gun_barrels[3];

player_gun_timer -= obj_global_timer.delta;

if (player_gun_timer < 0) player_gun_timer = 0;


if (mouse_check_button(1))
{
	firing = true;
}
else
{
	firing = false;
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
	muzzle_flash( 
	layer, 
	right_gun_barrel[0],
	right_gun_barrel[1],
	left_gun_barrel[0] ,
	left_gun_barrel[1] );

	player_gun_timer = player_gun_cooldown;

}
