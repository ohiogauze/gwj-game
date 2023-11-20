class_name CatalogueItem
extends Button


@onready var label: Label = $CenterContainer/Label


func setup(data) -> void:
	if not data or not data.id:
		label.text = "???"
		disabled = true
		modulate.a = .5
		focus_mode = Control.FOCUS_NONE
		return

	focus_mode = Control.FOCUS_ALL
	modulate.a = 1.0
	disabled = false
	label.text = data.title
