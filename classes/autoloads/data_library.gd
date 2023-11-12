## Loads all cats into memory.
extends Node


## All types of cats that can be picked up.
var cats: Array[CatData] = []


func _ready() -> void:
	cats.assign(CsvLoader\
		.open("res://data/catalogue.csv")\
		.map(CatData.new)
	)
