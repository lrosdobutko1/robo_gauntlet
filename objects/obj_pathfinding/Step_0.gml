mp_grid_clear_all(grid);

if mp_grid_get_cell(grid, mouse_x div 52, mouse_y div 52) == -1
{
	show_debug_message("occupied");
}
else
{
    show_debug_message("not occupied");
}

mp_grid_add_instances(grid, obj_solid_objects, 0);