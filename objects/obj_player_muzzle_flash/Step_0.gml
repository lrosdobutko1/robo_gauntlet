
if (instance_exists(gun_parent)) {
    if (is_left) {
        x = gun_parent.left_gun_barrel[0];
        y = gun_parent.left_gun_barrel[1];
    } else {
        x = gun_parent.right_gun_barrel[0];
        y = gun_parent.right_gun_barrel[1];
    }
}

if(obj_player_functions.player_gun_type != PLAYER_GUN_TYPE.BLASTER)
random_image_index = irandom_range(0,7);
else
random_image_index = irandom_range(8,10);
image_index = random_image_index;
if (!mouse_check_button_pressed(1)) instance_destroy();

