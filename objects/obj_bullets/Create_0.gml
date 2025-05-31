
//gun_type = 0;
frame_skip = 0;



sprite = spr_bullets_3;
choose_sprite_index = 6;
collision_offset = 0;

direction_angle = 0;
sprite_collision_mask(sprite,true,0,0,0,0,0,0,0);

image_speed = 0;

sprite_set_offset
(
spr_bullets,
sprite_get_width(spr_bullets)/2,
sprite_get_height(spr_bullets)
);

damage_to_player = 0;
damage_to_enemy = 0;
crit = damage_to_enemy * 2.5;
bullet_speed = 0;

wall_collision = get_bullet_sight_line(x,y, direction_angle, obj_obstacle, collision_offset);
end_x = wall_collision[0];
end_y = wall_collision[1];


function get_bullet_sight_line(x_start, y_start, angle, target_object, collision_offset)
{
    var max_distance = 800; 
    var step_size = 2;

    var x_end = x_start;
    var y_end = y_start;
    
    var line_length = max_distance;
    
    for (var i = 0; i < max_distance; i += step_size) 
    {
        var test_x = x_start + lengthdir_x(i, angle);
        var test_y = y_start + lengthdir_y(i, angle);
        
        if (position_meeting(test_x, test_y, target_object)) 
        {
            line_length = i - collision_offset;
            break;
        }
    }

    x_end = x_start + lengthdir_x(line_length, angle);
    y_end = y_start + lengthdir_y(line_length, angle);

    return [x_end, y_end];
}

created = true;
speed = bullet_speed * global.delta_multiplier + random_range(-2,2);
bounding_box_size_h = 0;
bounding_box_size_v = 0;

//function collision_box_size(x, y, creator, side_length_1, side_length_2, obj_to_check) 
//{
//    var angle = -image_angle;
//    var hit_instance = noone;

//    var half_side_1 = side_length_1 / 2;
//    var half_side_2 = side_length_2 / 2;

//    var cos_a = dcos(angle), sin_a = dsin(angle);

//    var x0 = -half_side_1, y0 = -half_side_2;
//    var x1 =  half_side_1, y1 = -half_side_2;
//    var x2 =  half_side_1, y2 =  half_side_2;
//    var x3 = -half_side_1, y3 =  half_side_2;

//    var rx0 = x + x0 * cos_a - y0 * sin_a;
//    var ry0 = y + x0 * sin_a + y0 * cos_a;

//    var rx1 = x + x1 * cos_a - y1 * sin_a;
//    var ry1 = y + x1 * sin_a + y1 * cos_a;

//    var rx2 = x + x2 * cos_a - y2 * sin_a;
//    var ry2 = y + x2 * sin_a + y2 * cos_a;

//    var rx3 = x + x3 * cos_a - y3 * sin_a;
//    var ry3 = y + x3 * sin_a + y3 * cos_a;

//    var inst;

//    inst = collision_line(rx0, ry0, rx1, ry1, obj_to_check, true, false);

//	if (inst != noone && 
//	inst.object_index != creator.object_index && 
//	!(creator.object_index == obj_player_functions && 
//	inst.object_index == obj_player_collision)) hit_instance = inst;

//	inst = collision_line(rx1, ry1, rx2, ry2, obj_to_check, true, false);
//	if (hit_instance == noone && 
//	inst != noone && 
//	inst.object_index != creator.object_index &&
//	!(creator.object_index == obj_player_functions && 
//	inst.object_index == obj_player_collision)) hit_instance = inst;

//	inst = collision_line(rx2, ry2, rx3, ry3, obj_to_check, true, false);
//	if (hit_instance == noone && 
//	inst != noone && 
//	inst.object_index != creator.object_index && 
//	!(creator.object_index == obj_player_functions && 
//	inst.object_index == obj_player_collision)) hit_instance = inst;

//	inst = collision_line(rx3, ry3, rx0, ry0, obj_to_check, true, false);
//	if (hit_instance == noone && 
//	inst != noone && 
//	inst.object_index != creator.object_index && 
//	!(creator.object_index == obj_player_functions && 
//	inst.object_index == obj_player_collision)) hit_instance = inst;
	
//    return hit_instance;
//}

function collision_box_size(x, y, creator, side_length_1, side_length_2, obj_to_check) 
{
    if (!instance_exists(creator)) return noone;

    var angle = -image_angle;
    var hit_instance = noone;

    var half_side_1 = side_length_1 / 2;
    var half_side_2 = side_length_2 / 2;

    var cos_a = dcos(angle), sin_a = dsin(angle);

    var x0 = -half_side_1, y0 = -half_side_2;
    var x1 =  half_side_1, y1 = -half_side_2;
    var x2 =  half_side_1, y2 =  half_side_2;
    var x3 = -half_side_1, y3 =  half_side_2;

    var rx0 = x + x0 * cos_a - y0 * sin_a;
    var ry0 = y + x0 * sin_a + y0 * cos_a;

    var rx1 = x + x1 * cos_a - y1 * sin_a;
    var ry1 = y + x1 * sin_a + y1 * cos_a;

    var rx2 = x + x2 * cos_a - y2 * sin_a;
    var ry2 = y + x2 * sin_a + y2 * cos_a;

    var rx3 = x + x3 * cos_a - y3 * sin_a;
    var ry3 = y + x3 * sin_a + y3 * cos_a;

    function valid_hit(inst) 
	{
        return instance_exists(inst)
            && inst.object_index != creator.object_index
            && !(creator.object_index == obj_player_functions && inst.object_index == obj_player_collision);
    }

    var inst;

    inst = collision_line(rx0, ry0, rx1, ry1, obj_to_check, true, false);
    if (valid_hit(inst)) hit_instance = inst;

    inst = collision_line(rx1, ry1, rx2, ry2, obj_to_check, true, false);
    if (hit_instance == noone && valid_hit(inst)) hit_instance = inst;

    inst = collision_line(rx2, ry2, rx3, ry3, obj_to_check, true, false);
    if (hit_instance == noone && valid_hit(inst)) hit_instance = inst;

    inst = collision_line(rx3, ry3, rx0, ry0, obj_to_check, true, false);
    if (hit_instance == noone && valid_hit(inst)) hit_instance = inst;

    return hit_instance;
}

