
nearby_radius = 400;

list_of_nearby_allies = ds_list_create();

player = obj_player_functions;
speed = 0;
walk_speed = 0.75;


update = false;
update_timer = 120;

path = path_add();
touching = false;
touching_cooldown = 100;
touching_counter  = touching_cooldown;

function move_away_from_nearest_ally(_ally_list,) {
	ds_list_clear(list_of_nearby_allies);

	var count = collision_circle_list(x, y, nearby_radius, test_object, 0, 1, list_of_nearby_allies, 0);

	var closest_ally = noone;
	var nearest_distance = nearby_radius;

	var _away_x, _away_y = 0;

	for (var i = 0; i < count; i++) {

	    var _inst = ds_list_find_value(list_of_nearby_allies, i);
	    var _dist = point_distance(x, y, _inst.x, _inst.y);

	    if (_dist < nearest_distance) {
	        nearest_distance = _dist;
	        closest_ally = _inst;
	    }
	
		var _dir = point_direction(x, y, _inst.x, _inst.y)-180;
	
		_away_x = lengthdir_x(walk_speed, _dir);
		_away_y = lengthdir_y(walk_speed, _dir);
	}

	if (closest_ally != noone) {
	    draw_line(x, y, x +_away_x, y +_away_y);
	}

}

function chase_the_player(_target_x, _target_y) {
	

	path_delete(path);
	path = path_add();
	
	
	mp_grid_path(obj_pathfinding.grid, path, x, y, _target_x, _target_y, true);

	var px = path_get_point_x(path, 1);
	var py = path_get_point_y(path, 1);

	vx = lengthdir_x(walk_speed, point_direction(x, y, px, py));
	vy = lengthdir_y(walk_speed, point_direction(x, y, px, py));

	//if (place_meeting(x + vx, y, test_object)) vx = 0;
	//if (place_meeting(x, y + vy, test_object)) vy = 0;

	x += vx;
	y += vy;

}


