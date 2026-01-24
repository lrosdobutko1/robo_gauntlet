
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

	//draw legs
	draw_sprite_ext(
	spr_player_legs,
	leg_anim,
	obj_player_functions.x,
	obj_player_functions.y,
	image_scale,image_scale,
	leg_angle,c_white,1);
	
	//draw guns
	draw_sprite_ext(
	spr_player_guns,gun_anim,
	obj_player_functions.x,
	obj_player_functions.y,
	image_scale,
	image_scale,
	rotation_angle,
	c_white,1);
	
	//draw torso
	draw_sprite_ext(
	spr_player_torso,0,
	obj_player_functions.x,
	obj_player_functions.y,
	image_scale,image_scale,
	rotation_angle,
	c_white,1);
}
