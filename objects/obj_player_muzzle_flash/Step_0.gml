if (instance_exists(gun_parent)) {
    if (is_left) {
        x = gun_parent.left_gun_barrel[0];
        y = gun_parent.left_gun_barrel[1];
    } else {
        x = gun_parent.right_gun_barrel[0];
        y = gun_parent.right_gun_barrel[1];
    }
}