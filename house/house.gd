##
class_name House
extends Node


##
@export_node_path var viewpoint_path: NodePath

##
@onready var clickable_label: Label = $HUD/ClickableLabel
##
@onready var raycast: RayCast3D = $RayCast3D
##
@onready var viewpoint: Viewpoint = get_node(viewpoint_path)

var clickable: Clickable


func _ready():
	viewpoint.activate()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and clickable:
		clickable.click()

	var viewport := get_viewport()
	var camera := viewport.get_camera_3d()
	var mouse_position := viewport.get_mouse_position()

	if mouse_position.x < 0 or mouse_position.x >= 380 or mouse_position.y < 0 or mouse_position.y >= 320:
		clickable = null
		clickable_label.text = ""
		return

	var from = camera.project_ray_origin(mouse_position)
	var to = camera.project_ray_normal(mouse_position) * 100

	raycast.global_position = from
	raycast.target_position = to

	var collider := raycast.get_collider()

	if collider == clickable:
		return

	clickable = collider
	clickable_label.text = ""

	if clickable is Clickable:
		clickable_label.text = clickable.title
