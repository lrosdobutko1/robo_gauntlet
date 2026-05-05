sprites = [
    spr_power_up_a,
    spr_power_up_b,
    spr_power_up_f,
    spr_power_up_g,
    spr_power_up_l,
    spr_power_up_s,
    spr_power_up_armor,
    spr_power_up_energy
];

sprite_index = sprites[irandom(array_length(sprites)-1)];
image_index = irandom(image_number);
image_speed = 1;