if (current_bullet_type.bullet_name !="Flamer") rotation = 0;

if (life_timer > 0) life_timer --;
if (life_timer == 0) instance_destroy();
//if (current_bullet_type.bullet_name == "Flamer") rotation++;

#region Destroy bullets past the screen edge

var px = obj_player_functions.x;
var py = obj_player_functions.y;
if (abs(x - px) > room_width/2 || abs(y - py) > room_height/2) {
    instance_destroy();
}

#endregion	


#region Collision with walls

var hit = false;

if (resolve_x_collision(hspeed, obj_obstacle)) hit = true;
if (resolve_y_collision(vspeed, obj_obstacle)) hit = true;

if (hit)
{
    if (current_bullet_type.bullet_name != "Flamer")
    {
        instance_destroy();
    }
    else
    {
        collision_timer--;
        if (collision_timer <= 0) instance_destroy();
    }
}
#endregion



