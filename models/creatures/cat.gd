class_name Cat
extends Node3D


func set_id(id: String) -> void:
	var material = $Cylinder.get_active_material(0)

	var path = "res://textures/cat_styles/%s.png" % id
	if FileAccess.file_exists(path):
		material.albedo_texture = load(path)
	else:
		material.albedo_texture = load("res://textures/cat_styles/unknown.png")
