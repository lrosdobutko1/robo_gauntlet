life_timer --;

var x_offset = lengthdir_x(speed, direction);
var y_offset = lengthdir_y(speed, direction);

if (life_timer <= 0 || (place_meeting(x + x_offset, y + y_offset, obj_obstacle)))
{
	instance_create_layer(x, y, "player_bullets", obj_spark_emitter)
	instance_destroy();
}
