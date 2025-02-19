
life_timer = 200;

muzzle_flash = random_range(0,3);
image_scale = 1;
image_index = muzzle_flash;
image_xscale = image_scale;
image_yscale = image_scale;


enum BULLET_TYPE 
{
	NONE,
	BULLET,
	GRENADE,
	MISSILE,
	SHOTGUN,
	LASER,
}

type = BULLET_TYPE.BULLET;
use_image_index = 3 + type;
max_damage = 10;
damage = 1;

switch (type)
{
	case BULLET_TYPE.BULLET:
		bullet_speed = 15;
		break;
	
	case BULLET_TYPE.GRENADE:
		bullet_speed = 8;
		break;
		
	case BULLET_TYPE.MISSILE:
		bullet_speed = 2;
		break;
		
	case BULLET_TYPE.SHOTGUN:
		bullet_speed = 12;
		break;
		
	case BULLET_TYPE.LASER:
		image_index = use_image_index;
		image_speed = 0;
		bullet_speed = 20;
		break;
	
	default:
		bullet_speed = 0;
		break;
}

speed = bullet_speed * global.delta_multiplier;