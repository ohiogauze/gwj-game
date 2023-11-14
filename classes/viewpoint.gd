##
class_name Viewpoint
extends Node


@onready var camera: Camera3D = $Camera3D


func _ready():
	deactivate()


func activate():
	camera.make_current()
	_set_collision_mode(true)


func deactivate():
	_set_collision_mode(false)


func _set_collision_mode(enabled: bool) -> void:
	var mode = 1 if enabled else 0
	for child in get_children():
		if child is Clickable:
			child.collision_layer = mode
			child.collision_mask = mode
