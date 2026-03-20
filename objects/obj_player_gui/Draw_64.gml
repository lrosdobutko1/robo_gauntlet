if (instance_exists(player)) {
	current_hp = player.current_hp;
	max_hp = player.max_hp;
	hp_percent = current_hp / max_hp;

	current_shield = player.current_shields;
	max_shields = player.max_shields;
	shield_percent = current_shield / max_shields;

	max_bar_length = 345 * shield_percent;
	current_bar_length = max_bar_length;

	took_damage = false;

	damage_counter = 240;
	damage_counter_value = damage_counter;

	rotation = 0;

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

set_gradient_shader(bar, shield_bar_start_color, shield_bar_end_color, 1);

current_bar_length = max_bar_length * shield_percent;
draw_sprite_ext(bar,0,186,95,current_bar_length,1,0,c_white,1);

shader_reset();

set_gradient_shader(border, c_ltgray, c_dkgray, 0);
draw_sprite_ext(border, 0, gui_position.self_x, gui_position.self_y, 1, 1, 0, c_white, 1);

shader_reset();

set_gradient_shader(orb, c_ltgray, c_dkgray, 0);
draw_sprite_ext(orb, 0, gui_position.self_x, gui_position.self_y, 1, 1, 0, c_white, 1);
shader_reset();

draw_set_color(c_white);
draw_arc_thick_rounded(gui_position.self_x, gui_position.self_y, 70, 8, -135 + rotation, 270, 64);

draw_set_font(fnt_hyper_oxide_32);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_colour(
gui_position.self_x - gui_position.offset_x, 
gui_position.self_y - gui_position.offset_y, 
round(hp_percent*100),
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



//if (took_damage) damage_counter_value --;
//if (damage_counter_value <= 0) {
//	took_damage = false;
//	damage_counter_value = damage_counter;
//}
//if(!took_damage) player.current_shields += 0.01;
//if (player.current_shields >= player.max_shields) player.current_shields = player.max_shields;

draw_triangle(
power_triangle.top[0],
power_triangle.top[1],
power_triangle.right[0],
power_triangle.right[1],
power_triangle.left[0],
power_triangle.left[1],
1
);


var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

if (point_distance(mouse_gui_x,
mouse_gui_y, 
p_t_current_center[0], 
p_t_current_center[1]
) <= power_triangle_center_radius)
{
	if (mouse_check_button(1)) {
		power_triangle_center_is_grabbed = true;
	}
	else power_triangle_center_is_grabbed = false;
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


if keyboard_check_pressed(ord("C")){
show_debug_message("pressed C");
};

draw_circle(
p_t_current_center[0],
p_t_current_center[1],
10,
1);

draw_line(
power_triangle.top[0],
power_triangle.top[1],
p_t_current_center[0],
p_t_current_center[1]
);

draw_line(
power_triangle.right[0],
power_triangle.right[1],
p_t_current_center[0],
p_t_current_center[1]
);

draw_line(
power_triangle.left[0],
power_triangle.left[1],
p_t_current_center[0],
p_t_current_center[1]
);


if (p_t_current_center[0] != p_t_center[0] || p_t_current_center[1] != p_t_center[1]) {
	
}
else {}

p_t_w_line_length = point_distance(p_t_top[0], p_t_top[1], p_t_current_center[0], p_t_current_center[1]);
p_t_s_line_length = point_distance(p_t_right[0], p_t_right[1], p_t_current_center[0], p_t_current_center[1]);
p_t_e_line_length = point_distance(p_t_left[0], p_t_left[1], p_t_current_center[0], p_t_current_center[1]);

debug = $"line lengths:" + "\n" +
$"weaponss: {p_t_w_line_length}" + "\n" +
$"weaponss: {p_t_s_line_length}" + "\n" +
$"weaponss: {p_t_e_line_length}" + "\n";

//show_debug_message(max_p_t_line_length);

