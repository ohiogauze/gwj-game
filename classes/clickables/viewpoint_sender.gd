## Sends the player to a new viewpoint.
class_name ViewpointSender
extends Clickable


@export_node_path("Viewpoint") var viewpoint_path: NodePath

@onready var target: Viewpoint = get_node(viewpoint_path)


func click():
	get_parent().deactivate()
	target.activate()
