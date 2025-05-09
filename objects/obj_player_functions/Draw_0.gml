
//animation machinegun barrels
if (firing)
{
	gun_counter ++;
	if (gun_counter % 3 == 0)
	gun_index ++;
	if (gun_index == 3) gun_index = 0;
}

draw_self();
draw_sprite_ext(spr_player_guns,gun_index,obj_player_functions.x,obj_player_functions.y,image_scale,image_scale,rotation_angle,c_white,1);
draw_sprite_ext(spr_player_torso,0,obj_player_functions.x,obj_player_functions.y,image_scale,image_scale,rotation_angle,c_white,1);

draw_text(x+10, y+10, "FPS: " + string(fps_real));
//draw_text(x-50, y-50, "x: " + string(x) + " " + "y: " + string(y));
//draw_triangle(x,y,gun_barrels[0], gun_barrels[1], gun_barrels[2], gun_barrels[3], 5);
//draw_triangle(x,y, casings_eject[0], casings_eject[1], casings_eject[2], casings_eject[3],3);

//var width = 100;
//var height = 200;
//var x1 = x - width/2;
//var x2 = x + width/2;
//var y1 = y + height/2;
//var y2 = y - height/2;
//var x3 = x + width/2;
//var x4 = x - width/2;
//var y3 = y + height/2;
//var y4 = y - height/2;


//draw_line(x1,y1,x2,y2);
//draw_line(x3,y3,x4,y4);

//draw_rotating_square(x, y, 200, 100);