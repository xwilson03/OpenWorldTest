extends Node
class_name Chunk

@export var high_lod: Node3D
@export var med_lod: Node3D
@export var low_lod: Node3D

enum LOD {
    HIGH,
    MEDIUM,
    LOW,
}

func _ready() -> void:
    set_lod(LOD.LOW)

func set_lod(lod: LOD) -> void:
    match lod:

        LOD.HIGH:
            remove_child(low_lod)
            remove_child(med_lod)
            add_child(high_lod)

        LOD.MEDIUM:
            remove_child(low_lod)
            add_child(med_lod)
            remove_child(high_lod)

        LOD.LOW:
            add_child(low_lod)
            remove_child(med_lod)
            remove_child(high_lod)
