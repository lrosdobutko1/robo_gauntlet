speed = 1;
direction = 0;

mv_speed = 2;
h_speed = hspeed;
v_speed = vspeed;



function resolve_x_collision(_dx, _obj)
{
    if (_dx == 0) return noone;


    return instance_place(x + _dx, y, _obj);
}

function resolve_y_collision(_dy, _obj)
{
    if (_dy == 0) return noone;

    return instance_place(x, y + _dy, _obj);
}

