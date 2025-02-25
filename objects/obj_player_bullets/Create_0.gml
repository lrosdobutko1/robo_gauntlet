
life_timer = 200;

image_scale = 1;
image_xscale = image_scale;
image_yscale = image_scale;
image_speed = 0;
//bullet_type = "machinegun";
//switch (bullet_type) {
//    case 0: // Machinegun
//        speed = 10;
//        damage = 5;
//        break;
        
//    case 1: // Shotgun
//        speed = 8;
//        damage = 15;
//        break;

//    case 2: // Grenade
//        speed = 6;
//        damage = 30;
//        break;

//    case 3: // Blaster
//        speed = 12;
//        damage = 10;
//        break;

//    default:
//        speed = 5;
//        damage = 1;
//        break;
//}

//use_image_index = bullet_type;
max_damage = 10;
damage = 1;
bullet_speed = 20;

speed = bullet_speed * global.delta_multiplier;

image_index = 0;
