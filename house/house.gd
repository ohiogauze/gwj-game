##
class_name House
extends Node


signal cat_collected(id: String)
signal viewpoint_changed(viewpoint: Viewpoint)

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
	$Ceiling.show()
	viewpoint.activate()

	for child in $Viewpoints.get_children():
		child.activated.connect(func ():
			viewpoint = child
			viewpoint_changed.emit(viewpoint)
		)
		child.cat_collected.connect(collect_cat)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and clickable and clickable_label.text != "":
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
		clickable_label.text = clickable.title if clickable else ""
		return

	clickable_label.text = ""

	if not collider or collider.is_queued_for_deletion():
		return

	clickable = collider

	if clickable is Clickable:
		clickable_label.text = clickable.title


func collect_cat(id: String):
	viewpoint.deactivate()

	clickable = null
	clickable_label.text = ""

	cat_collected.emit(id)
