weapon_anim_frame_number = sprite_get_number(current_primary_weapon.weapon_sprite);

if (instance_exists(obj_player_gui)) {
	max_weapon_modifier = 1.5 - (obj_player_gui.p_t_w_line_length / obj_player_gui.max_p_t_line_length);
	max_shield_modifier = 1.5 - (obj_player_gui.p_t_s_line_length / obj_player_gui.max_p_t_line_length);
	max_engine_modifier = 1.5 - (obj_player_gui.p_t_e_line_length / obj_player_gui.max_p_t_line_length);
}

if (current_hp == max_hp) health_state = PLAYER_HEALTH_STATE.FULL;
if (current_hp < max_hp && current_hp > max_hp * 0.75) health_state = PLAYER_HEALTH_STATE.HIGH;
if (current_hp <= max_hp * 0.75 && current_hp > max_hp * 0.25) health_state = PLAYER_HEALTH_STATE.MED;
if (current_hp <= max_hp * 0.25 && current_hp > max_hp * 0.10) health_state = PLAYER_HEALTH_STATE.LOW;
if (current_hp <= max_hp * 0.10 && current_hp > 0) health_state = PLAYER_HEALTH_STATE.CRITICAL;
if (current_hp <= 0) health_state = PLAYER_HEALTH_STATE.DEAD;
if (explode_anim >= (sprite_get_number(spr_explode1) - 1)) health_state = PLAYER_HEALTH_STATE.DESTROYED;



switch (health_state)
{
	case PLAYER_HEALTH_STATE.FULL:
	{
		
		break;
	}
	
	case PLAYER_HEALTH_STATE.HIGH:
	{
		break;
	}
	
	case PLAYER_HEALTH_STATE.MED:
	{
		break;
	}
	
	case PLAYER_HEALTH_STATE.LOW:
	{
		break;
	}
	
	case PLAYER_HEALTH_STATE.CRITICAL:
	{
		break;
	}
	
	case PLAYER_HEALTH_STATE.DEAD:
	{
		break;
	}
	
		case PLAYER_HEALTH_STATE.DESTROYED:
	{
		instance_destroy();
		break;
	}
	
}

//moving
x = obj_player_collision.x;
y = obj_player_collision.y;

//shooting
var prev_gun = gun_select_keys; // Store previous selection

// Check for key press
for (var i = 1; i <= array_length(primary_weapon_slots)-1; i++)
{
    if (keyboard_check_pressed(ord(string(i))))
    {
        gun_select_keys = i;
        break;
    }
}

if (gun_select_keys != prev_gun)
{
    current_primary_weapon = primary_weapon_slots[gun_select_keys];
}

switch (current_primary_weapon) {
	case player_weapons.autocannon: {
		
		if (firing)gun_anim += 0.5;	
		break;
	}
	
	case player_weapons.shotgun: {
	    if (firing)
	    {
	        if (can_animate_guns)
	        {
	            gun_anim += 0.25;

	            if (gun_anim >= weapon_anim_frame_number)
	            {
	                gun_anim = weapon_anim_frame_number;
	                can_animate_guns = false;
	                anim_guns_counter = 0;
	            }
	        }
	        else
	        {
	            anim_guns_counter++;

	            if (anim_guns_counter >= current_primary_weapon.firing_speed)
	            {
	                can_animate_guns = true;
	                gun_anim = 0; // restart animation
					firing = false;
	            }
	        }
	    }

	    break;
	}
	
		case player_weapons.blaster: {
		
		if (firing)gun_anim += 0.1;	
		break;
	}
	
}
	
	
	



//if (gun_anim >= weapon_anim_frame_number-1) gun_anim = 0;


#region assume mouse is not within the power triangle area to be able to shoot
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

if (!point_in_triangle(
mouse_gui_x,
mouse_gui_y,
obj_player_gui.power_triangle.top[0],
obj_player_gui.power_triangle.top[1],
obj_player_gui.power_triangle.right[0],
obj_player_gui.power_triangle.right[1],
obj_player_gui.power_triangle.left[0],
obj_player_gui.power_triangle.left[1]
))
{
	can_shoot = true;
	
	if (mouse_check_button(2) && rockets_ready) {
		firing_rockets = true;
	}
		if (firing_rockets) {
			
		if (rockets_ready) {
			
			find_gun_create_coordinates(rocket_launchers,15,210);
		
			if (firing_speed_cooldown <= 0)
			{

			    shoot_bullets(
			        current_secondary_weapon.bullet_type,
			        rocket_launchers[0],
					rocket_launchers[1],
					current_secondary_weapon.num_bullets,
					rotation_angle-150+random_range(-10,30),
					current_secondary_weapon.bullet_angle
			    );
				rocket_counter --;

			    firing_speed_cooldown = current_secondary_weapon.firing_speed;
			}

			if (firing_speed_cooldown == current_secondary_weapon.firing_speed * current_secondary_weapon.firing_speed_offset)
			{

			    shoot_bullets(
			        current_secondary_weapon.bullet_type,
			        rocket_launchers[2],
					rocket_launchers[3],
					current_secondary_weapon.num_bullets,
					rotation_angle+150+random_range(-30,10),
					current_secondary_weapon.bullet_angle
			    );
				rocket_counter --;
				
				if (rocket_counter <= 0) {
					rockets_ready = false;
					firing_rockets = false;
						
				}
			} 
		}
	}

	if (!rockets_ready) {
		
		player_rocket_timer --;
		if player_rocket_timer <= 0 {
			player_rocket_timer	= player_rocket_cooldown;
			rocket_counter = max_rockets;
			rockets_ready = true;
		}
	}

	//fire primary
	if (mouse_check_button(1))
	{
		firing = true;
		var angle_variance_1 = random_range(-12,12);
		var speed_variance_1 = random_range(-1,1);
		var angle_variance_2 = random_range(-12,12);
		var speed_variance_2 = random_range(-0.5,0.5);

		find_gun_create_coordinates(gun_barrels, 26, 60);
		find_gun_create_coordinates(casings_eject, 15, 190);
		if (firing_speed_cooldown <= 0)
	    {
			
			//shell casings
			shoot_bullets(
	            bullet_types.shell_casing,
	            casings_eject[0],
	            casings_eject[1],
				1,
				rotation_angle - 90 + angle_variance_1,
				0
	        );
			//muzzle flash
			draw_muzzle_flash_right = true;
			
			//shoot_bullets(
			shoot_bullets(
	            current_primary_weapon.bullet_type,
	            gun_barrels[0],
				gun_barrels[1],
				current_primary_weapon.num_bullets,
				rotation_angle,
				current_primary_weapon.bullet_angle
	        );
			

	        firing_speed_cooldown = round(current_primary_weapon.firing_speed / max_weapon_modifier);
	    }


	    if (firing_speed_cooldown == round(current_primary_weapon.firing_speed / max_weapon_modifier * current_primary_weapon.firing_speed_offset))
	    {
			//shell casings
			shoot_bullets(
	            bullet_types.shell_casing,
	            casings_eject[2],
	            casings_eject[3],
				1,
				rotation_angle + 90 + angle_variance_2,
				0
	        );
			//muzzle flash
			draw_muzzle_flash_left = true;
			//shoot_bullets(
	        //    bullet_types.muzzle_flash,
	        //    gun_barrels[2],
			//	gun_barrels[3],
			//	1,
			//	rotation_angle,
			//	0
	        //);
			//shoot_bullets(
			shoot_bullets(
	            current_primary_weapon.bullet_type,
	            gun_barrels[2],
				gun_barrels[3],
				current_primary_weapon.num_bullets,
				rotation_angle,
				current_primary_weapon.bullet_angle
	        );
			
	    }
	}
	
	else {
		if (current_primary_weapon != player_weapons.shotgun) firing = false; 
		}

}

if (draw_muzzle_flash_left) draw_muzzle_flash_left_counter --;
if (draw_muzzle_flash_left_counter <= 0) {
	draw_muzzle_flash_left = false;
	draw_muzzle_flash_left_counter = muzzle_flash_counters;
}

if (draw_muzzle_flash_right) draw_muzzle_flash_right_counter --;
if (draw_muzzle_flash_right_counter <= 0) {
	draw_muzzle_flash_right = false;
	draw_muzzle_flash_right_counter = muzzle_flash_counters;
}

else can_shoot = false;

#endregion

if (current_shields < max_shields && shield_recharge_cooldown <= 0 ) {
	current_shields = min(max_shields, current_shields + (shield_recharge_rate * max_shield_modifier));
}



if (shield_recharge_cooldown > 0)
shield_recharge_cooldown -= 1 * max_shield_modifier;

if (firing_speed_cooldown > 0)
firing_speed_cooldown --;


show_debug_message(rotation_angle);









