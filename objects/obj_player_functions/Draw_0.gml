
if (health_state != PLAYER_HEALTH_STATE.DEAD && health_state != PLAYER_HEALTH_STATE.DESTROYED)
{

	h_speed = obj_player_collision.h_speed * global.delta_multiplier;
	v_speed = obj_player_collision.v_speed * global.delta_multiplier;

	var next_x = x + obj_player_collision.h_speed;
	var next_y = y + obj_player_collision.v_speed;

	rotation_angle = point_direction(x,y, mouse_x,mouse_y);
	var travel_angle = point_direction(x,y, next_x, next_y);
	var angle_diff = angle_difference(leg_angle, travel_angle)

	//animate legs

	moving = (h_speed != 0 || v_speed != 0);

	if (moving)
	{
		leg_angle -= min(abs(angle_diff), 5) * sign(angle_diff);
		leg_anim += 0.25;
		if (leg_anim > (sprite_get_number(spr_player_legs) - 1)) leg_anim = 0;
	}

	draw_sprite_ext(
	spr_player_legs,
	leg_anim,
	obj_player_functions.x,
	obj_player_functions.y,
	image_scale,image_scale,
	leg_angle,c_white,1);

	draw_sprite_ext(
	spr_player_guns,gun_anim,
	obj_player_functions.x,
	obj_player_functions.y,
	image_scale,
	image_scale,
	rotation_angle,
	c_white,1);

	draw_sprite_ext(
	spr_player_torso,0,
	obj_player_functions.x,
	obj_player_functions.y,
	image_scale,image_scale,
	rotation_angle,
	c_white,1);

	//draw_text(x+10, y+10, "FPS: " + string(fps_real));

	if (player_gun_type != PLAYER_GUN_TYPE.BLASTER)
	{
		if (muzzle_flash_frame >= 7) muzzle_flash_frame = 0;
	}
	else if (player_gun_type == PLAYER_GUN_TYPE.BLASTER)
	{
		if (muzzle_flash_frame >= 10) muzzle_flash_frame = 8;
	}

	if (firing) muzzle_flash(gun_barrels, firing_speed, firing_offset, player_gun_type, muzzle_flash_frame);

	muzzle_flash_frame ++;

	//flash on hit
	if (flash > 0)
	{
		var torso = spr_player_torso;
		var sprite_color = (c_white);
		flash --;
		shader_set(sdr_white_flash);
		draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
		shader_reset();
	}
}

else
{
	draw_sprite_ext(explode_sprite,explode_anim,x,y,3,3,random_range(0,359),c_white,1)
	explode_anim += 0.5;
}
//var triangle = [];
// find_gun_create_coordinates(triangle, 28, 60);
//draw_triangle(x,y,triangle[0], triangle[1], triangle[2], triangle[3],5)