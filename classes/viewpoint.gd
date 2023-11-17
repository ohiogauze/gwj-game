##
class_name Viewpoint
extends Node


signal activated
signal cat_collected(cat_id: String)

@onready var camera: Camera3D = $Camera3D

var total_cats := 0


func _ready():
	deactivate()

	for child in get_children():
		if child is CatCollector:
			total_cats += 1
			child.collected.connect(func ():
				cat_collected.emit(child.cat_id)
			)


func activate():
	activated.emit()
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
