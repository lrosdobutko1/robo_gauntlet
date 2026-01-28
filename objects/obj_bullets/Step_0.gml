if (life_timer = 0) instance_destroy();

if (life_timer > 0) life_timer --;

#region Destroy bullets past the screen edge
var px = obj_player_functions.x;
var py = obj_player_functions.y;
if (
    abs(x - px) > room_width/2 ||
    abs(y - py) > room_height/2
) {
    instance_destroy();

}
#region	


#region Collision with walls
if (place_meeting(x+hspeed, y, obj_obstacle)) {
	while (!place_meeting(x+sign(hspeed),y, obj_obstacle)) x = x + sign(hspeed);
	
	instance_destroy();
}

if (place_meeting(x, y + vspeed, obj_obstacle)) {
	while (!place_meeting(x, y+sign(vspeed), obj_obstacle)) y = y + sign(vspeed);
	
	instance_destroy();
}
#endregion

show_debug_message(life_timer);

