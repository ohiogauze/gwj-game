extends Control


@onready var catalogue: Catalogue = $Catalogue
@onready var conversation: Conversation =$Conversation
@onready var curtain = $Curtain
@onready var fur: FUR = $MarginContainer/HBoxContainer/VBoxContainer/FUR
@onready var house: House = $MarginContainer/HBoxContainer/SubViewportContainer/SubViewport/House

var room_count := 0


func _ready():
	catalogue.hide()
	conversation.hide()

	catalogue.closed.connect(func():
		catalogue.hide()
		house.viewpoint.activate()
	)
	fur.set_count(house.viewpoint.get_cat_count())

	house.viewpoint.deactivate()
	curtain.show()

	conversation.play("res://dialogues/opening.dialogue", false)
	await conversation.closed

	var tween = create_tween()
	tween.tween_property(curtain, "modulate:a", 0.0, 1.0)
	await tween.finished
	curtain.hide()

	house.viewpoint.activate()


func _on_Catalogue_button_pressed() -> void:
	house.viewpoint.deactivate()
	catalogue.setup()
	catalogue.show()


func _on_house_cat_collected(id) -> void:
	catalogue.collected_cats.append(id)
	$CatCollectionScreen.play(id)


func _on_cat_collection_screen_closed() -> void:
	var cat_count = house.viewpoint.get_cat_count()
	fur.set_count(cat_count)

	if cat_count == 0:
		room_count += 1
		curtain.show()
		var in_tween = create_tween()
		in_tween.tween_property(curtain, "modulate:a", 1.0, 1.0)
		in_tween.play()
		conversation.play(house.viewpoint.haunt, true)
		await conversation.closed
		var out_tween = create_tween()
		out_tween.tween_property(curtain, "modulate:a", 0.0, 1.0)
		out_tween.play()
		out_tween.finished.connect(func ():
			curtain.hide()
		)
		conversation.play("res://dialogues/call_%s.dialogue" % room_count, false)
		await conversation.closed

	house.viewpoint.activate()


func _on_house_viewpoint_changed(viewpoint) -> void:
	fur.set_count(viewpoint.get_cat_count())
