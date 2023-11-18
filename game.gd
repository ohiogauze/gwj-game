extends Control


@onready var catalogue: Catalogue = $Catalogue
@onready var fur: FUR = $MarginContainer/HBoxContainer/VBoxContainer/FUR
@onready var house: House = $MarginContainer/HBoxContainer/SubViewportContainer/SubViewport/House


func _ready():
	catalogue.hide()
	catalogue.closed.connect(func():
		catalogue.hide()
		house.viewpoint.activate()
	)
	fur.set_count(house.viewpoint.get_cat_count())


func _on_Catalogue_button_pressed() -> void:
	house.viewpoint.deactivate()
	catalogue.show()


func _on_house_cat_collected(id) -> void:
	$CatCollectionScreen.play(id)


func _on_cat_collection_screen_closed() -> void:
	house.viewpoint.activate()
	fur.set_count(house.viewpoint.get_cat_count())


func _on_house_viewpoint_changed(viewpoint) -> void:
	fur.set_count(viewpoint.get_cat_count())
