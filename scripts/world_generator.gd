extends Node
class_name WorldGenerator

const chunk_scene = preload("res://prefabs/chunk.tscn")

func _ready():
	add_child(chunk_scene.instantiate())
