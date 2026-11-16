extends "res://weapons/ranged/carbon_bow/carbon_bow.gd"

const sprites_path = "res://mods-unpacked/RomatoPotato-WCDoT/sprites";
const mod_suffix = "WCDoT";
const file_extension = "png";

const carbon_bow_types = {
	"res://weapons/ranged/carbon_bow/carbon_bow.png": "",
	"res://weapons/ranged/carbon_bow/carbon_bow_arrow_melee.png": "_melee",
	"res://weapons/ranged/carbon_bow/carbon_bow_arrow_range.png": "_range",
	"res://weapons/ranged/carbon_bow/carbon_bow_arrow_elemental.png": "_elemental",
	"res://weapons/ranged/carbon_bow/carbon_bow_arrow_enginering.png": "_enginering",
}

func update_sprite(new_sprite: Texture) -> void :
	.update_sprite(new_sprite);

	var sprite_path = sprite.texture.resource_path

	if "RomatoPotato-WCDoT" in sprite_path or "_empty" in sprite_path:
		return

	var carbon_bow_type = carbon_bow_types[sprite_path]
	var texture_path = "%s/%s/%s_%s%s.%s" % [sprites_path, weapon_id, mod_suffix, tier + 1, carbon_bow_type, file_extension];

	if ResourceLoader.exists(texture_path):
		var new_texture = load(texture_path);
		sprite.texture = new_texture
