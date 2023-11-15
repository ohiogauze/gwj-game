## Listing of all cats which have been found so far.
class_name Catalogue
extends Control


signal closed

@onready var items = $Container/HBoxContainer/Control/VBoxContainer/Items.get_children() as Array[CatalogueItem]
@onready var description: Label = $Container/HBoxContainer/Details/VBoxContainer/Control2/ScrollContainer/Description
@onready var title: Label = $Container/HBoxContainer/Details/VBoxContainer/Control/Title

func _ready() -> void:
	for item in items:
		var index = item.get_index()

		if DataLibrary.cats.size() > index:
			var data = DataLibrary.cats[index]
			item.setup(data)
			item.pressed.connect(func ():
				set_item(data)
			)
		else:
			item.setup(null)

	$Container/HBoxContainer/Control/VBoxContainer/Button.pressed.connect(func():
		closed.emit()
	)

	set_item(DataLibrary.cats[0])


func set_item(data):
	title.text = data.title
	description.text = data.entry
	$Container/HBoxContainer/Details/VBoxContainer/Control2/ScrollContainer.scroll_vertical = 0
	$Container/HBoxContainer/Details/VBoxContainer/Control/SubViewportContainer/SubViewport/Cat.set_id(data.id)
