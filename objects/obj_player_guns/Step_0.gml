x = obj_player_torso.x;
y = obj_player_torso.y;
image_angle = obj_player_torso.image_angle;


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

if (firing and obj_global_timer.player_gun_timer == 0)
{
	ShootBullets(obj_player_bullet, "player_bullets");
	obj_global_timer.player_gun_timer = obj_global_timer.player_gun_cooldown;
}
