x = obj_player_torso.x;
y = obj_player_torso.y;
image_angle = obj_player_torso.image_angle;

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
	ShootBullets(obj_player_bullets, "player_bullets");
	player_gun_timer = player_gun_cooldown;
}
show_debug_message(global.delta_multiplier);