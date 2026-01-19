draw_self();

// draw bounding box on top
draw_set_alpha(1);
draw_set_color(c_lime);
draw_rectangle(
    bbox_left,
    bbox_top,
    bbox_right,
    bbox_bottom,
    true
);