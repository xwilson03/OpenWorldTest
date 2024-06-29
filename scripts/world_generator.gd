extends Node3D
class_name WorldGenerator

@export var world_radius: int
@export var chunk_size: float
@export var chunk_boundary_tolerance: float

@export var high_lod_distance: float
@export var medium_lod_distance: float

const chunk_scene: PackedScene = preload("res://prefabs/chunk.tscn")

var world_chunks: ChunkGrid
var world_size: Vector2i


func _ready() -> void:
    # Initialize global world variables
    Globals.world_radius = world_radius
    Globals.chunk_size = chunk_size
    Globals.chunk_boundary_tolerance = chunk_boundary_tolerance

    Globals.high_lod_distance = high_lod_distance
    Globals.medium_lod_distance = medium_lod_distance

    # Allocate chunk array
    var row_size: int = Globals.world_radius * 2
    world_size = Vector2i(row_size, row_size)
    world_chunks = ChunkGrid.new(
        self,
        world_size,
        chunk_scene,
        Vector2(chunk_size, chunk_size)
    )
