//draw the shield bar and health percentage readout
if (instance_exists(player)) {
	current_hp = player.current_hp;
	max_hp = player.max_hp;
	hp_percent = current_hp / max_hp;

	current_shield = player.current_shields;
	max_shields = player.max_shields;
	shield_percent = current_shield / max_shields;

	max_shield_bar_length = 355 * shield_percent;
	current_shield_bar_length = max_shield_bar_length;

	max_color = 255;
	shield_color_offset = player.current_shields / player. max_shields;
	shield_bar_start_color = make_colour_rgb(
		max_color * (1-shield_color_offset), 
		max_color * shield_color_offset, 
		max_color * shield_color_offset
	);



	var _rotation_offset = 1 - (player.current_hp / player.max_hp);
	rotation = (rotation > 359) ? 0 : rotation + (1.5 * _rotation_offset);

	current_hp = player.current_hp;
	max_hp = player.max_hp;
	hp_percent = (current_hp / max_hp);

	current_shield = player.current_shields;
	max_shields = player.max_shields;
	shield_percent = current_shield / max_shields;
	if (shield_percent <= 0) shield_percent = 0;
	if (shield_percent >= 1) shield_percent = 1;

	shield_color_offset_start = shield_percent;
	shield_color_offset_end = shield_percent;

	shield_color_offset_start = power(shield_color_offset_start, 0.8);
	shield_color_offset_end = power(shield_color_offset_end, 0.4);

	shield_bar_start_color = make_colour_rgb(
	    max_color * (1 - shield_color_offset_start),
	    max_color * shield_color_offset_start,
	    max_color * shield_color_offset_start
		);

	shield_bar_end_color = make_colour_rgb(
	255,
	255*shield_color_offset_end, 
	255*shield_color_offset_end
	);

	draw_sprite_ext(bg, 0, gui_position.self_x, gui_position.self_y, 1, 1, 0, c_white, 1);


	#region XP bar
	current_xp = player.current_experience_points;
	max_xp = player.experience_points_to_next_level;
	xp_percent = current_xp / max_xp;

	current_xp_bar_length = max_xp_bar_length * xp_percent;
	draw_sprite_ext(bar,0,gui_position.xp_bar_x,gui_position.xp_bar_y,current_xp_bar_length,0.30,0,c_white,1);
	draw_text_ext_transformed(gui_position.level_label_x,gui_position.level_label_y,$"Level      {player.current_level}",1,200,.75,.75,0);

	#endregion

	set_gradient_shader(bar, shield_bar_start_color, shield_bar_end_color, 1);

	current_shield_bar_length = max_shield_bar_length * shield_percent;
	draw_sprite_ext(bar,0,gui_position.self_x+110,gui_position.self_y+4,current_shield_bar_length,1,0,c_white,1);

	shader_reset();

	set_gradient_shader(border, c_ltgray, c_dkgray, 0);
	draw_sprite_ext(border, 0, gui_position.self_x, gui_position.self_y, 1, 1, 0, c_white, 1);

	shader_reset();

	set_gradient_shader(orb, c_ltgray, c_dkgray, 0);
	draw_sprite_ext(orb, 0, gui_position.self_x, gui_position.self_y, 1, 1, 0, c_white, 1);
	shader_reset();

	draw_set_color(c_white);
	draw_arc_thick_rounded(gui_position.self_x, gui_position.self_y, 102, 13, -135 + rotation, 270, 64);




	#region health
	draw_set_font(fnt_hyper_oxide_32);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text_colour(
	gui_position.self_x - gui_position.offset_x, 
	gui_position.self_y - gui_position.offset_y, 
	$"{round(hp_percent*100)}",
	c_black,
	c_grey,
	c_blue,
	c_red,1);

	draw_set_font(fnt_arial_black_16);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text_colour(
	gui_position.self_x - gui_position.offset_x, 
	gui_position.self_y - gui_position.offset_y+35, 
	"%",
	c_black,
	c_grey,
	c_blue,
	c_red,1);
	#endregion

	#region primary and secondary weapon info
	draw_set_font(fnt_hyper_oxide_16);
	draw_text_colour(
	gui_position.weapon_label_x,
	gui_position.weapon_label_y,
	player.current_primary_weapon.weapon_name,
	c_white, 
	c_white, 
	c_white, 
	c_white, 
	1);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	//draw secondary weapon ticks
	for (var i = 0; i < player.rocket_counter; i++) {
		draw_sprite(spr_player_rocket_tick,0, gui_position.self_x + 110 + 14*i, gui_position.self_y + 50);
	}
	#endregion

	#region power triangle
	var weapons_color = get_value_from_length(p_t_w_line_length, max_p_t_line_length);
	var shields_color = get_value_from_length(p_t_s_line_length, max_p_t_line_length);
	var engines_color = get_value_from_length(p_t_e_line_length, max_p_t_line_length);

	var triangle_color = make_colour_rgb(weapons_color, engines_color, shields_color);

	draw_line_width_colour(
	power_triangle.top[0],
	power_triangle.top[1],
	power_triangle.right[0],
	power_triangle.right[1],
	3,
	triangle_color,
	triangle_color
	);

	draw_line_width_colour(
	power_triangle.top[0],
	power_triangle.top[1],
	power_triangle.left[0],
	power_triangle.left[1],
	3,
	triangle_color,
	triangle_color
	);

	draw_line_width_colour(
	power_triangle.right[0],
	power_triangle.right[1],
	power_triangle.left[0],
	power_triangle.left[1],
	3,
	triangle_color,
	triangle_color
	);


	var mouse_gui_x = device_mouse_x_to_gui(0);
	var mouse_gui_y = device_mouse_y_to_gui(0);

	if (point_distance(mouse_gui_x,
	mouse_gui_y, 
	p_t_current_center[0], 
	p_t_current_center[1]
	) <= power_triangle_center_radius)
	{
		if (mouse_check_button_pressed(1)) {
			power_triangle_center_is_grabbed = true;
		}
		if (mouse_check_button_released(1)) {
	    power_triangle_center_is_grabbed = false;
		p_t_center_coords_index = 0;
	}
	}

	if (power_triangle_center_is_grabbed)
	{
	    if (point_in_triangle(
	        mouse_gui_x,
	        mouse_gui_y,
	        power_triangle.top[0],
			power_triangle.top[1],
	        power_triangle.right[0],
			power_triangle.right[1],
	        power_triangle.left[0],
			power_triangle.left[1]
	    )) {
	        p_t_current_center[0] = mouse_gui_x;
	        p_t_current_center[1] = mouse_gui_y;
	    }
	    else {
	        power_triangle_center_is_grabbed = false;
	    }
	}


	//cycle_power_triangle(p_t_points, p_t_center_coords_index);
	if keyboard_check_pressed(ord("C")) {
		p_t_current_center = [p_t_points[p_t_center_coords_index][0], p_t_points[p_t_center_coords_index][1]]
		p_t_center_coords_index ++;
		
		if (p_t_center_coords_index > array_length(p_t_points)-1) {
		p_t_center_coords_index = 0;
		}
			
	}

	draw_circle_colour(
	p_t_current_center[0],
	p_t_current_center[1],
	10,
	triangle_color,
	triangle_color,
	1
	);

	draw_line_width_colour(
	power_triangle.top[0],
	power_triangle.top[1],
	p_t_current_center[0],
	p_t_current_center[1],
	2,
	triangle_color,
	triangle_color
	);

	draw_line_width_colour(
	power_triangle.right[0],
	power_triangle.right[1],
	p_t_current_center[0],
	p_t_current_center[1],
	2,
	triangle_color,
	triangle_color
	);

	draw_line_width_colour(
	power_triangle.left[0],
	power_triangle.left[1],
	p_t_current_center[0],
	p_t_current_center[1],
	2,
	triangle_color,
	triangle_color
	);


	if (p_t_current_center[0] != p_t_center[0] || p_t_current_center[1] != p_t_center[1]) {
	
	}
	else {}

	p_t_w_line_length = point_distance(p_t_top[0], p_t_top[1], p_t_current_center[0], p_t_current_center[1]);
	p_t_s_line_length = point_distance(p_t_right[0], p_t_right[1], p_t_current_center[0], p_t_current_center[1]);
	p_t_e_line_length = point_distance(p_t_left[0], p_t_left[1], p_t_current_center[0], p_t_current_center[1]);

	draw_text(p_t_top[0]+15, p_t_top[1]-9, "weapons");
	draw_text(p_t_left[0]-45, p_t_left[1]-28, "engines");
	draw_text(p_t_right[0]-45, p_t_right[1]+7, "shields");

	#endregion


}

if (draw_timer <= 0) {
	fps_text = string(round(fps_real));
	draw_timer = draw_timer_cooldown;
}
draw_timer --;

draw_text(1200, 10, $"FPS: {fps_text}");
var _num_instances = instance_number(obj_enemy_basic_runner);
draw_text(1200, 30, $"Instanes: {_num_instances}");
