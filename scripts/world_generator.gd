extends Node3D
class_name WorldGenerator

@export var world_radius: int
@export var chunk_size: float
@export var lod_ranges: Array[int]

const chunk_scene: PackedScene = preload("res://prefabs/chunk_lod0.tscn")

var world_chunks: ChunkGrid
var world_size: Vector2i


func _ready() -> void:
    # Initialize global world variables
    Globals.world_radius = world_radius
    Globals.chunk_size = chunk_size
    Globals.lod_ranges = lod_ranges

    # Allocate chunk array
    var row_size: int = Globals.world_radius * 2
    world_size = Vector2i(row_size, row_size)
    world_chunks = ChunkGrid.new(
        self,
        world_size,
        chunk_scene,
        Vector2(chunk_size, chunk_size)
    )
