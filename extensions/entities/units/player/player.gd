extends "res://entities/units/player/player.gd"

enum TextureType {DEFAULT, COOLDOWN, ANIMATION}

const sprites_path = "res://mods-unpacked/RomatoPotato-WCDoT/sprites";
const mod_suffix = "WCDoT";
const file_extension = "png";

const file_path = {
	TextureType.COOLDOWN: "on_cooldown",
	TextureType.ANIMATION: "animation",
}

const whip_weapons = ["weapon_whip", "weapon_flail"]

func add_weapon(weapon:WeaponData, pos:int)->void:
	.add_weapon(weapon, pos);
	
	var added_weapon = current_weapons[-1]

	replace_whip_animation_textures(added_weapon, weapon.weapon_id)

	var texture_path = "%s/%s/%s_%s.%s" % [sprites_path, weapon.weapon_id, mod_suffix, weapon.tier + 1, file_extension];

	if ResourceLoader.exists(texture_path):
		var new_texture = load(texture_path)

		added_weapon.sprite.texture = new_texture
		added_weapon._original_sprite = new_texture
		
		if added_weapon is RangedWeapon:
			added_weapon.not_throwned_projectile_texture = new_texture

		if added_weapon.stats.custom_on_cooldown_sprite != null or (added_weapon is RangedWeapon and added_weapon.throwned_projectile_texture != null):
			var cooldown_texture_path = "%s/%s/%s/%s_%s.%s" % [sprites_path, weapon.weapon_id, file_path[TextureType.COOLDOWN], mod_suffix, weapon.tier + 1, file_extension]
			
			if ResourceLoader.exists(cooldown_texture_path):
				var new_cooldown_texture = load(cooldown_texture_path)

				if new_cooldown_texture == null:
					return

				if added_weapon.stats.custom_on_cooldown_sprite != null:
					added_weapon.stats.custom_on_cooldown_sprite = new_cooldown_texture

				if added_weapon is RangedWeapon and added_weapon.throwned_projectile_texture != null:
					added_weapon.throwned_projectile_texture = new_cooldown_texture


func replace_whip_animation_textures(weapon:Node, weapon_id:String)->void:
	var animation_name = "lash"

	if (whip_weapons.has(weapon_id)):
		var anim_player_origin = weapon.get_node_or_null("AnimationPlayer");

		if (!anim_player_origin):
			return;

		var anim = anim_player_origin.get_animation(animation_name).duplicate(true);
		var track_idx = anim.find_track("Sprite:texture");

		if track_idx != -1:
			anim_player_origin.add_animation(animation_name, anim)

			var texture_path = "%s/%s" % [sprites_path, weapon.weapon_id];
			var tail_path = "%s/%s_%s_tail.%s" % [texture_path, mod_suffix, weapon.tier + 1, file_extension]
			var anim_path = "%s/%s/%s_%s" % [texture_path, file_path[TextureType.ANIMATION], mod_suffix, weapon.tier + 1]
			
			var anim_default_path = "%s/%s_%s.%s" % [texture_path, mod_suffix, weapon.tier + 1, file_extension];
			var anim_0_path = "%s_%s.%s" % [anim_path, 0, file_extension];
			var anim_1_path = "%s_%s.%s" % [anim_path, 1, file_extension];
			# *_animation_2.png sprite in whips sprites has only Brotato's hand
			var anim_3_path = "%s_%s.%s" % [anim_path, 3, file_extension];
			var anim_4_path = "%s_%s.%s" % [anim_path, 4, file_extension];
			
			if ResourceLoader.exists(tail_path):
				var tail_node = weapon.get_node_or_null("Tail/WhipImpactTail");

				if (tail_node):
					tail_node.texture = load(tail_path)

			if ResourceLoader.exists(anim_default_path):
				var anim_default_texture = load(anim_default_path);
				anim.track_set_key_value(track_idx, 0, anim_default_texture)
				anim.track_set_key_value(track_idx, 6, anim_default_texture)

			if ResourceLoader.exists(anim_0_path):
				var anim_0_texture = load(anim_0_path);
				anim.track_set_key_value(track_idx, 1, anim_0_texture)

			if ResourceLoader.exists(anim_1_path):
				var anim_1_texture = load(anim_1_path);
				anim.track_set_key_value(track_idx, 2, anim_1_texture)

			if ResourceLoader.exists(anim_3_path):
				var anim_3_texture = load(anim_3_path);
				anim.track_set_key_value(track_idx, 4, anim_3_texture)

			if ResourceLoader.exists(anim_4_path):
				var anim_4_texture = load(anim_4_path);
				anim.track_set_key_value(track_idx, 5, anim_4_texture)
