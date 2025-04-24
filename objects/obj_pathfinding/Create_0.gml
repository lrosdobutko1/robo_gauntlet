
global.grid = mp_grid_create(0, 0, room_width div 26, room_height div 26, 26, 26);


mp_grid_add_instances(global.grid, obj_wall_parent,true);


mp_grid_clear_all(global.grid);

mp_grid_add_instances(global.grid, obj_wall_parent, true);