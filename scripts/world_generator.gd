extends Node
class_name WorldGenerator

@export var world_radius: int = 50
@export var chunk_size: float = 10.1

const chunk_scene = preload("res://prefabs/chunk.tscn")

var world_chunks: Array[Node3D] = []


func _init():
    # Initialize global world variables
    Globals.world_radius = world_radius
    Globals.chunk_size = chunk_size
    
    # Allocate chunk array
    var row_size: int = ((Globals.world_radius * 2) - 1)
    world_chunks.resize(row_size ** 2)
    
    # Populate chunk array
    var offset: float = ((row_size / 2.0) * Globals.chunk_size) - (Globals.chunk_size / 2.0)
    
    for i in world_chunks.size():
        # Instantiate chunk at index-based position offset
        var new_chunk = chunk_scene.instantiate()
        new_chunk.translate(Vector3(
            (i % row_size) * Globals.chunk_size - offset,
            0,
            (i / row_size) * Globals.chunk_size - offset
        ))
        
        world_chunks.insert(i, new_chunk)
        add_child(new_chunk)
