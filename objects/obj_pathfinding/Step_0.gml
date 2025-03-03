

mp_grid_clear_all(global.grid);

if (mp_grid_get_cell(global.grid, mouse_x div 26, mouse_y div 26) == -1)
{
	show_debug_message("occupied");
}
else
{
    show_debug_message("not occupied");
}

mp_grid_add_instances(global.grid,obj_wall_parent, true);