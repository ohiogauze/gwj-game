extends Control


func _process(delta: float):
	$Rays1.rotation += delta * .5
	$Rays2.rotation -= delta * .6
