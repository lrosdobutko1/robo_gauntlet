ds_list_clear(list_of_nearby_allies);

var count = collision_circle_list(x, y, 2500, test_object_1, 0, 1, list_of_nearby_allies, 0);

var closest_ally = noone;
var nearest_distance = 2500;

var _away_x = 0;
var _away_y = 0;

for (var i = 0; i < count; i++) {

    var _inst = ds_list_find_value(list_of_nearby_allies, i);
    var _dist = point_distance(x, y, _inst.x, _inst.y);

    if (_dist < nearest_distance) {
        nearest_distance = _dist;
        closest_ally = _inst;
    }
	
	var _dir = point_direction(x, y, _inst.x, _inst.y);

}

player = obj_player_functions;
target_x = player.x;
target_y = player.y;

chase_the_player(nearest_distance, walk_speed, target_x, target_y);


if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
	if (mouse_check_button(1)) {
		x = mouse_x;
		y = mouse_y;
	}
}
if (id == instance_find(object_index, 0)) {
	
	if(instance_exists(closest_ally))
		show_debug_message(point_distance(x, y, closest_ally.x, closest_ally.y));
}

