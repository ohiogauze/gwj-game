## Listing of all cats which have been found so far.
class_name Catalogue
extends Control


signal closed

@onready var items = $Container/HBoxContainer/Control/VBoxContainer/Items.get_children() as Array[CatalogueItem]


func _ready() -> void:
	for item in items:
		var index = item.get_index()
		item.setup(DataLibrary.cats[index] if DataLibrary.cats.size() > index else null)

	$Container/HBoxContainer/Control/VBoxContainer/Button.pressed.connect(func():
		closed.emit()
	)
