if (instance_exists(player)) {
	current_hp = player.current_hp;
	max_hp = player.max_hp;
	hp_percent = current_hp / max_hp;

	current_shield = player.current_shields;
	max_shields = player.max_shields;
	shield_percent = current_shield / max_shields;

	max_bar_length = 355 * shield_percent;
	current_bar_length = max_bar_length;

	max_color = 255;
	shield_color_offset = player.current_shields / player. max_shields;
	shield_bar_start_color = make_colour_rgb(
		max_color * (1-shield_color_offset), 
		max_color * shield_color_offset, 
		max_color * shield_color_offset
	);

}

var _rotation_offset = 1 - (obj_player_functions.current_hp / obj_player_functions.max_hp);
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

set_gradient_shader(bar, shield_bar_start_color, shield_bar_end_color, 1);

current_bar_length = max_bar_length * shield_percent;
draw_sprite_ext(bar,0,gui_position.self_x+110,gui_position.self_y+4,current_bar_length,1,0,c_white,1);

shader_reset();

set_gradient_shader(border, c_ltgray, c_dkgray, 0);
draw_sprite_ext(border, 0, gui_position.self_x, gui_position.self_y, 1, 1, 0, c_white, 1);

shader_reset();

set_gradient_shader(orb, c_ltgray, c_dkgray, 0);
draw_sprite_ext(orb, 0, gui_position.self_x, gui_position.self_y, 1, 1, 0, c_white, 1);
shader_reset();

draw_set_color(c_white);
draw_arc_thick_rounded(gui_position.self_x, gui_position.self_y, 102, 13, -135 + rotation, 270, 64);

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

draw_set_font(fnt_hyper_oxide_16);
draw_text_colour(
gui_position.weapon_label_x,
gui_position.weapon_label_y,
obj_player_functions.current_weapon.weapon_name,
c_white, 
c_white, 
c_white, 
c_white, 
1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

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
	if keyboard_check_pressed(ord("C")){
		p_t_current_center = [p_t_points[p_t_center_coords_index][0], p_t_points[p_t_center_coords_index][1]]
		show_debug_message(p_t_center_coords_index);
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





