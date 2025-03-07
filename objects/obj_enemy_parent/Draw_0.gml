torso = spr_enemy1_torso;
rotation_angle = point_direction(x,y, obj_player_torso.x,obj_player_torso.y)-90;
sight_cone = get_sight_cone(rotation_angle+90);

//draw legs


//draw the torso
if (alive)
{
	draw_self();
	//draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
	
	if (flash > 0)
	{
		flash --;
		shader_set(sh_white);
		draw_self();
		draw_sprite_ext(torso, 0, x, y, image_scale, image_scale, rotation_angle, sprite_color, 1);
		shader_reset();
	}
}


draw_path(path,x,y,true);

//draw other elements
//draw_triangle(x, y, sight_cone[0], sight_cone[1], sight_cone[2], sight_cone[3], 4);
//draw_line(x,y,facing_x, facing_y);

draw_text(x-100, y-32, string(id));

var nearest_ally = noone;
var min_dist = 999999; // Start with a large number

with (obj_enemy_parent) {
    if (id != other.id) { // Exclude itself
        var dist = point_distance(other.x, other.y, x, y);
        if (dist < min_dist) {
            min_dist = dist;
            nearest_ally = id;
        }
    }
}

if (nearest_ally != noone) 
{
    var distance = point_distance(x, y, nearest_ally.x, nearest_ally.y);
    var dir_away = point_direction(x, y, nearest_ally.x, nearest_ally.y) + 180; // Reverse direction

    // Make the line length inversely proportional to distance (closer = longer line)
    var line_length = clamp(50 - distance, 0, 50); // Ensures a minimum length of 50 and max of 200

    var point_x = x + lengthdir_x(line_length, dir_away);
    var point_y = y + lengthdir_y(line_length, dir_away);
}
