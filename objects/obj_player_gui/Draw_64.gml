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
shield_color_offset_end = power(shield_color_offset_end, 0.6);

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

draw_set_font(fnt_hyper_oxide);
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

draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (took_damage) damage_counter_value --;
if (damage_counter_value <= 0) {
	took_damage = false;
	damage_counter_value = damage_counter;
}
if(!took_damage) player.current_shields += 0.01;
if (player.current_shields >= player.max_shields) player.current_shields = player.max_shields;
