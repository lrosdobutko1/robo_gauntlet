//calculate_damage(obj_player_functions, 10);


//instance_create_layer(mouse_x, mouse_y,"player_layer",obj_enemy_basic_runner);


var clevel = 20;
var elevel = 20;
var stddev = 9;




function random_normal(_mean, _stdev) {
    var r1 = random(1);
    var r2 = random(1);

    var z = sqrt(-2 * ln(u1)) * cos(2 * pi * u2);

    return  round(_mean + z * _stdev);
}

//i_level determined by the level of the monster dropping the item.
var i_level = clamp (elevel - random_normal(0, stddev), 0, elevel);

//q_level determined by player level +/- 3
var q_level = clamp(clevel - random_normal(0, stddev), 0, clevel + irandom_range(-3,3) );
// MAX(CEILING(q_level/2,1), i_level - FLOOR(0.75*q_level,1))

var affix_level = max( round(q_level/2), i_level - floor(0.75*q_level));

debug = $"quality level: {q_level}, item level: {i_level}, affix level: {affix_level}";
show_debug_message( debug );