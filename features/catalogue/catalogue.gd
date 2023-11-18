## Listing of all cats which have been found so far.
class_name Catalogue
extends Control


signal closed

var collected_cats: Array[String] = []

@onready var button: Button = $Container/HBoxContainer/Control/VBoxContainer/Button
@onready var cat: Cat = $Container/HBoxContainer/Details/VBoxContainer/Control/SubViewportContainer/SubViewport/Cat
@onready var items = $Container/HBoxContainer/Control/VBoxContainer/Items.get_children() as Array[CatalogueItem]
@onready var description: Label = $Container/HBoxContainer/Details/VBoxContainer/Control2/ScrollContainer/Description
@onready var scroll_container: ScrollContainer = $Container/HBoxContainer/Details/VBoxContainer/Control2/ScrollContainer
@onready var title: Label = $Container/HBoxContainer/Details/VBoxContainer/Control/Title

func _ready() -> void:
	button.pressed.connect(func():
		closed.emit()
	)

	for item in items:
		var index = item.get_index()

		if DataLibrary.cats.size() > index:
			item.pressed.connect(func ():
				set_item(DataLibrary.cats[index])
			)

	setup()

func setup():
	for item in items:
		var index = item.get_index()

		if DataLibrary.cats.size() > index:
			var data = DataLibrary.cats[index]

			if collected_cats.has(data.id):
				item.setup(data)
			else:
				item.setup(null)
		else:
			item.setup(null)

	set_item(null)


func set_item(data):
	if not data:
		data = {
			"title": "",
			"entry": "",
			"id": "not_real_this_is_fake",
		}

	title.text = data.title
	description.text = data.entry
	scroll_container.scroll_vertical = 0
	cat.set_id(data.id)
