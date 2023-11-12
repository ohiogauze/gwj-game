## Data which defines a cat.
class_name CatData
extends Object


## Unique internal ID for the cat.
var id: String
## Visible name for the cat.
var title: String
## Line of text that appears when cat is picked up.
var tagline: String
## Description of cat shown in CATalogue.
var entry: String


func _init(data: Dictionary) -> void:
	id = data["id"]
	title = data["name"]
	tagline = data["tagline"]
	entry = data["entry"]
