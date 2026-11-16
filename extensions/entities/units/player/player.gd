extends "res://entities/units/player/player.gd"

var spritesPath = "res://mods-unpacked/RomatoPotato-WCDoT/sprites/"

func add_weapon(weapon:WeaponData, pos:int)->void:
	.add_weapon(weapon, pos);
	
	var added_weapon = current_weapons[-1]
	var texture_path = spritesPath + "/" + weapon.weapon_id + "/WCDoT_" + str(weapon.tier + 1) + ".png"

	if ResourceLoader.exists(texture_path):
		var new_texture = load(texture_path)

		added_weapon.sprite.texture = new_texture
		added_weapon._original_sprite = new_texture
		
		if added_weapon is RangedWeapon:
			added_weapon.not_throwned_projectile_texture = new_texture

		if added_weapon.stats.custom_on_cooldown_sprite != null or (added_weapon is RangedWeapon and added_weapon.throwned_projectile_texture != null):
			var newCooldownTexture = load(spritesPath + "/" + weapon.weapon_id + "/on_cooldown/WCDoT_" + str(weapon.tier + 1) + ".png")
			
			if newCooldownTexture == null:
				return
			
			if added_weapon.stats.custom_on_cooldown_sprite != null:
				added_weapon.stats.custom_on_cooldown_sprite = newCooldownTexture
			
			if added_weapon is RangedWeapon and added_weapon.throwned_projectile_texture != null:
				added_weapon.throwned_projectile_texture = newCooldownTexture
