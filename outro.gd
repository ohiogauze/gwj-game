extends Control


func _on_button_pressed() -> void:
	$Catalogue.enable_all = true
	$Catalogue.setup()
	$Catalogue.show()
	$TitleCard.hide()


func _on_catalogue_closed() -> void:
	$Catalogue.hide()
	$TitleCard.show()
