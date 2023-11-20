## Loads all cats into memory.
extends Node


## All types of cats that can be picked up.
var cats: Array = []


func _ready() -> void:
	cats.assign(CsvLoader\
		.open("res://data/catalogue.csv")\
		.map(func (data):
			return {
				"id": data["id"],
				"title": data["name"],
				"tagline": data["tagline"],
				"entry": data["entry"],
				"texture": load("res://textures/cat_styles/%s.png" % data["id"])
			})
	)

	print(cats)
