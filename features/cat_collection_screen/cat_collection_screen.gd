## Screen to show the collection of a cat.
class_name CatCollectionScreen
extends Control


signal closed

@onready var cat: Cat = $MarginContainer/Control/SubViewportContainer/SubViewport/Cat
@onready var cat_name: Label = $Name/CenterContainer/VBoxContainer/CatName
@onready var close: Button = $MarginContainer/Control/Close
@onready var tagline: Label = $Tagline/Label


func _ready():
	hide()


func play(id: String) -> void:
	var data: CatData

	for model in DataLibrary.cats:
		if id == model.id:
			data = model

	if not data:
		return

	show()
	close.hide()
	modulate.a = 0.0
	cat.set_id(id)

	cat_name.text = data.title
	tagline.text = data.tagline

	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
	tween.play()

	await tween.finished
	close.show()



func _on_close_pressed() -> void:
	close.hide()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.play()

	await tween.finished
	closed.emit()
