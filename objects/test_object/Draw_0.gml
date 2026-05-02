ds_list_clear(list_of_nearby_allies);

var count = collision_circle_list(x, y, nearby_radius, test_object, 0, 1, list_of_nearby_allies, 0);

var closest_ally = noone;
var nearest_distance = nearby_radius;

var _away_x = 0;
var _away_y = 0;

for (var i = 0; i < count; i++) {

    var _inst = ds_list_find_value(list_of_nearby_allies, i);
    var _dist = point_distance(x, y, _inst.x, _inst.y);

    if (_dist < nearest_distance) {
        nearest_distance = _dist;
        closest_ally = _inst;
    }
	
	var _dir = point_direction(x, y, _inst.x, _inst.y)-180;
	
	_away_x = lengthdir_x(100, _dir);
	_away_y = lengthdir_y(100, _dir);
}


draw_line(x, y, x +_away_x, y +_away_y);


draw_sprite(spr_obstacle, 0, x, y);