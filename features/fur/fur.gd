class_name FUR
extends Control


func set_count(count: int) -> void:
	$Control.modulate.a = .5 if count == 0 else 1.0
	$Control/Count.text = "%s" % count
