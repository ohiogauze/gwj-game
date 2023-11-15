class_name CatalogueItem
extends Button


@onready var label: Label = $CenterContainer/Label


func setup(data: CatData) -> void:
	if not data or not data.id:
		label.hide()
		return

	label.text = data.title
