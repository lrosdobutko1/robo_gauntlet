
target_delta = 1/game_get_speed(gamespeed_fps);

actual_delta = delta_time/1000000; //microseconds

//multiplier by which to multiply all timed effects like movement and cooldowns
global.delta_multiplier = actual_delta/target_delta;

elapsed_frames += global.delta_multiplier;
elapsed_milliseconds += actual_delta*1000;
elapsed_seconds += actual_delta;

//show_debug_message("");
//show_debug_message("frames: " +string(elapsed_frames));
//show_debug_message("millis: " +string(elapsed_milliseconds));
//show_debug_message("second: " +string(elapsed_seconds));