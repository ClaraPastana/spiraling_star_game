draw_clear(c_white);

surface_set_target(painting_surface)
draw_set_color(c_blue);
draw_circle(window_mouse_get_x(),window_mouse_get_y(), 8, false);

surface_reset_target();

