ds_list_clear(list_of_nearby_allies);

var count = collision_circle_list(x, y, nearby_radius, test_object, 0, 1, list_of_nearby_allies, 0);

var closest_ally = noone;
var nearest_distance = nearby_radius;

for (var i = 0; i < count; i++) {

    var _inst = ds_list_find_value(list_of_nearby_allies, i);
    var _dist = point_distance(x, y, _inst.x, _inst.y);

    if (_dist < nearest_distance) {
        nearest_distance = _dist;
        closest_ally = _inst;
    }
}

var _away_x = 0;
var _away_y = 0;

if (closest_ally != noone) {
    var _dir = point_direction(x, y, closest_ally.x, closest_ally.y) - 180;
    _away_x = lengthdir_x(100, _dir);
    _away_y = lengthdir_y(100, _dir);
}

touching = false;

if (place_meeting(x + walk_speed, y, test_object)) {
    touching = true;
}

if (place_meeting(x, y + walk_speed, test_object)) {
    touching = true;
}

if (touching && closest_ally != noone) {
    touching_counter--;
    target_x = x + _away_x;
    target_y = y + _away_y;
} else {
    target_x = player.x;
    target_y = player.y;
}

if (touching_counter <= 0) touching_counter = touching_cooldown;

chase_the_player(target_x, target_y);


if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
	if (mouse_check_button(1)) {
		x = mouse_x;
		y = mouse_y;
	}
}

