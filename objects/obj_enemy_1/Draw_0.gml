var torso = spr_enemy1_torso;

var rotation = point_direction(x,y, obj_player_torso.x,obj_player_torso.y)-90;

var sight_cone = get_sight_cone();

draw_self();

draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation, c_green, 1);

draw_triangle(x, y, sight_cone[0], sight_cone[1], sight_cone[2], sight_cone[3], 4);


//draw_line(x,y,facing_x, facing_y);