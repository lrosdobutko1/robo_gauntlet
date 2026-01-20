player = obj_player_functions;

border = spr_player_health_border;
orb = spr_player_health_orb;
spinner = spr_player_health_spinner;
bar = spr_player_shield_bar;


current_hp = player.current_hp;
max_hp = player.max_hp;
hp_percent = current_hp / max_hp;

current_shield = player.current_shields;
max_shields = player.max_shields;
shield_percent = current_shield / max_shields;

max_bar_length = 265 * shield_percent;
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

shield_bar_end_color = make_colour_rgb(
	max_color * (1-shield_color_offset), 
	max_color * (1-shield_color_offset), 
	max_color * (1-shield_color_offset)
);

gui_position = {
	self_x: 100,
	self_y: 100,
	offset_x: 5,
	offset_y: 5
	};
	
uUv          = shader_get_uniform(sdr_gradient, "uUv");
uOffset      = shader_get_uniform(sdr_gradient, "uOffset");
uColorTop    = shader_get_uniform(sdr_gradient, "uColorTop");
uColorBottom = shader_get_uniform(sdr_gradient, "uColorBottom");

offset = 0.0;

uHorizontal = shader_get_uniform(sdr_gradient, "uHorizontal");

function set_gradient_shader(sprite, top_col, bot_col, horizontal)
{
    shader_set(sdr_gradient);

    var _uv = sprite_get_uvs(sprite, 0);

    // orientation
    shader_set_uniform_f(uHorizontal, horizontal);

    // UV range must match axis
    if (horizontal)
    {
        // left → right
        shader_set_uniform_f(uUv, _uv[0], _uv[2]);
    }
    else
    {
        // top → bottom
        shader_set_uniform_f(uUv, _uv[1], _uv[3]);
    }

    shader_set_uniform_f(uOffset, offset);

    // top / left color
    shader_set_uniform_f(
        uColorTop,
        color_get_red(top_col)   / 255,
        color_get_green(top_col) / 255,
        color_get_blue(top_col)  / 255
    );

    // bottom / right color
    shader_set_uniform_f(
        uColorBottom,
        color_get_red(bot_col)   / 255,
        color_get_green(bot_col) / 255,
        color_get_blue(bot_col)  / 255
    );
}


function draw_arc_thick_rounded(x, y, radius, thickness, start_angle, arc_angle, steps)
{
    var outer_r = radius;
    var inner_r = radius - thickness;
    var mid_r   = radius - thickness * 0.5;

    var end_angle = start_angle + arc_angle;
    var step      = arc_angle / steps;
    var angle_len = end_angle - start_angle;

    // -------------------------------------------------
    // Arc body (gradient applied)
    // -------------------------------------------------

    set_gradient_shader(spr_white_pixel, c_ltgray, c_dkgray, 1);

    var tex = sprite_get_texture(spr_white_pixel, 0);
    draw_primitive_begin_texture(pr_trianglestrip, tex);

    for (var a = start_angle; a <= end_angle; a += step)
    {
        var cs = dcos(a);
        var sn = -dsin(a);

        // angle → normalized U (0..1)
        var u = (a - start_angle) / angle_len;

        // outer edge
        draw_vertex_texture(
            x + cs * outer_r,
            y + sn * outer_r,
            u, 0
        );

        // inner edge
        draw_vertex_texture(
            x + cs * inner_r,
            y + sn * inner_r,
            u, 1
        );
    }

    draw_primitive_end();
    shader_reset();

    // -------------------------------------------------
    // Rounded end caps (match gradient color visually)
    // -------------------------------------------------

    var cap_r = thickness * 0.5;

    // start cap
    var cs0 = dcos(start_angle);
    var sn0 = -dsin(start_angle);
    draw_circle_colour(
        x + cs0 * mid_r,
        y + sn0 * mid_r,
        cap_r,
		c_ltgray,
		c_ltgray,
        false
    );

    // end cap
    var cs1 = dcos(end_angle);
    var sn1 = -dsin(end_angle);
    draw_circle_color(
        x + cs1 * mid_r,
        y + sn1 * mid_r,
        cap_r,
		c_dkgray,
		c_dkgray,
        false
    );
}
