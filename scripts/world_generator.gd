extends Node3D
class_name WorldGenerator

@export var world_radius: int = 60
@export var chunk_size: float = 10
@export var chunk_boundary_tolerance: float = 0.1

const chunk_scene = preload("res://prefabs/chunk.tscn")

var world_chunks: ChunkGrid
var world_size: Vector2i


func _init() -> void:
    # Initialize global world variables
    Globals.world_radius = world_radius
    Globals.chunk_size = chunk_size
    Globals.chunk_boundary_tolerance = chunk_boundary_tolerance
    
    # Connect global signals
    Globals.entered_new_chunk.connect(_on_entered_new_chunk)
    
    # Allocate chunk array
    var row_size: int = Globals.world_radius * 2
    world_size = Vector2i(row_size, row_size)
    world_chunks = ChunkGrid.new(
        self,
        world_size,
        chunk_scene,
        Vector2(chunk_size, chunk_size)
    )

func _on_entered_new_chunk(direction: Globals.DIRECTION) -> void:
    world_chunks.move(direction)
