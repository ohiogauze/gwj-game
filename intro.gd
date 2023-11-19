extends Control


func _ready():
	$TitleCard.modulate.a = 0.0
	$WorkInProgress.modulate.a = 0.0

	await fade_to($TitleCard, 1.0)
	await get_tree().create_timer(3.0).timeout
	await fade_to($TitleCard, 0.0)

	await fade_to($WorkInProgress, 1.0)
	await get_tree().create_timer(5.0).timeout
	await fade_to($WorkInProgress, 0.0)

	get_tree().change_scene_to_file("res://game.tscn")


func fade_to(node: Control, value: float) -> void:
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", value, 1.0)
	tween.play()
	await tween.finished
