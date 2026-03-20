player = obj_player_functions;

border = spr_player_health_border;
orb = spr_player_health_orb;
spinner = spr_player_health_spinner;
bar = spr_player_shield_bar;

current_hp = 0;
max_hp = 0;
hp_percent = 1;

current_shield = 0;
max_shields = 0;
shield_percent = 1;

max_bar_length = 345 * shield_percent;
current_bar_length = max_bar_length;

took_damage = false;

damage_counter = 240;
damage_counter_value = damage_counter;

rotation = 0;

max_color = 255;
shield_color_offset = 0;
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


function GuiPositions(_x, _y){
	return {
		self_x: _x,
		self_y: _y,
		offset_x: 5,
		offset_y: 10,
		weapon_label_x: _x+650,
		weapon_label_y: _y-58
	};
}
gui_position = GuiPositions(100, 100);
	
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

power_triangle_radius = 150;
power_triangle_center = [600, 600];
power_triangle_center_radius = 10;
theta = 0;
theta_r = degtorad(theta);

power_triangle_center_is_grabbed = false;


p_t_top				= [power_triangle_center[0] + power_triangle_radius * cos(theta_r), power_triangle_center[1] + power_triangle_radius * sin(theta_r)];
p_t_right			= [power_triangle_center[0] + power_triangle_radius * cos(theta_r + degtorad(120)), power_triangle_center[1] + power_triangle_radius * sin(theta_r + degtorad(120))];
p_t_left			= [power_triangle_center[0] + power_triangle_radius * cos(theta_r + degtorad(240)), power_triangle_center[1] + power_triangle_radius * sin(theta_r + degtorad(240))];
p_t_top_right		= [(p_t_top[0] + p_t_right[0])/2, (p_t_top[1] + p_t_right[1])/2];
p_t_right_left		= [(p_t_right[0] + p_t_left[0])/2, (p_t_right[1] + p_t_left[1])/2];
p_t_left_top		= [(p_t_left[0] + p_t_top[0])/2, (p_t_left[1] + p_t_top[1])/2];
p_t_center			= power_triangle_center;
p_t_current_center	= [p_t_center[0],p_t_center[1]];

power_triangle = {
	top:    p_t_top, 
	right:  p_t_right,
	left:   p_t_left,
	top_right: p_t_top_right,
	right_left: p_t_right_left,
	left_top: p_t_left_top,
	center: p_t_current_center
};

p_t_w_line_length = point_distance(p_t_top[0], p_t_top[1], p_t_current_center[0], p_t_current_center[1]);
p_t_s_line_length = point_distance(p_t_right[0], p_t_right[1], p_t_current_center[0], p_t_current_center[1]);
p_t_e_line_length = point_distance(p_t_left[0], p_t_left[1], p_t_current_center[0], p_t_current_center[1]);

max_p_t_line_length = point_distance(
power_triangle.top[0], 
power_triangle.top[1],
power_triangle.right[0],
power_triangle.right[1]
);

power_triangle_center_coords = ["center", "top", "right", "left", "top right", "right left", "left top"]; 

p_t_points = [
p_t_top,
p_t_right,
p_t_left,
p_t_top_right,		
p_t_right_left,		
p_t_left_top,		
p_t_center,			
p_t_current_center	
];

power_triangle_center_coords_index = 0;

function cycle_power_triangle(_array, _index) {
	
	if (_index > _array.array_length(_array)) _index = 0;
		
}
	
	

	
	