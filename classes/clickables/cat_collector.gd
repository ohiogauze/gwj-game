##
class_name CatCollector
extends Clickable


signal collected

@export var cat_id: String = ""


func click():
	collected.emit()
	queue_free()
