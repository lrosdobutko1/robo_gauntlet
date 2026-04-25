
mv_speed = 1;
player = obj_player_functions;

path = path_add();

if (instance_exists(player)) {
	target_x = player.x;
	target_y = player.y;
}
else {
	target_x = x;
	target_y = y;
}


if (instance_exists(player))
facing = point_direction(x,y,player.x,player.y);

else facing = noone;

previous_x = x;
previous_y = y;

current_vx = x - previous_x;
current_vy = y - previous_y;

alarm[0] = 20;




function move_to_target_with_avoidance(_grid, _target, _speed, _blocker, _slow_factor)
{
    path_delete(path);
    path = path_add();

    if (!mp_grid_path(_grid, path, x, y, _target.x, _target.y, true))
        return;

    var px = path_get_point_x(path, 1);
    var py = path_get_point_y(path, 1);

    var dir = point_direction(x, y, px, py);

    vx = lengthdir_x(_speed, dir);
    vy = lengthdir_y(_speed, dir);

    previous_x = x;
    previous_y = y;

    if (place_meeting(x + vx, y, _blocker))
        vx *= _slow_factor;

    if (place_meeting(x, y + vy, _blocker))
        vy *= _slow_factor;

    x += vx;
    y += vy;

    current_vx = x - previous_x;
    current_vy = y - previous_y;
}


function chase_the_player() {
path_delete(path);
path = path_add();

mp_grid_path(obj_pathfinding.grid, path, x, y, player.x, player.y, true);

var px = path_get_point_x(path, 1);
var py = path_get_point_y(path, 1);

vx = lengthdir_x(mv_speed, point_direction(x, y, px, py));
vy = lengthdir_y(mv_speed, point_direction(x, y, px, py));

previous_x = x;
previous_y = y;

if (place_meeting(x + vx, y, test_object)) vx = 0;
if (place_meeting(x, y + vy, test_object)) vy = 0;

x += vx;
y += vy;

current_vx = x - previous_x;
current_vy = y - previous_y;
}
