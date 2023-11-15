extends Control


@onready var catalogue: Catalogue = $Catalogue
@onready var house: House = $MarginContainer/HBoxContainer/SubViewportContainer/SubViewport/House


func _ready():
	catalogue.hide()
	catalogue.closed.connect(func():
		catalogue.hide()
		house.viewpoint.activate()
	)


func _on_Catalogue_button_pressed() -> void:
	house.viewpoint.deactivate()
	catalogue.show()
