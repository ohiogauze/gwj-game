class_name Cat
extends Node3D


func set_id(id: String) -> void:
	var material = $Cylinder.get_active_material(0)

	var path = "res://textures/cat_styles/%s.png" % id
	material.albedo_texture = load(path if id else "res://textures/cat_styles/unknown.png")
