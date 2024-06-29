extends Node3D
class_name Chunk

@export var _high_lod: Node3D
@export var _med_lod: Node3D
@export var _low_lod: Node3D

var _cur_lod: LOD

enum LOD {
    HIGH,
    MEDIUM,
    LOW,
}

func _ready() -> void:
    remove_child(_high_lod)
    remove_child(_med_lod)
    _cur_lod = LOD.LOW

    set_lod(Globals.global_lod)

    Globals.set_lod.connect(set_lod)

func set_lod(new_lod: LOD) -> void:

    if new_lod == _cur_lod:
        return

    # Remove current LOD
    match _cur_lod:
        LOD.HIGH:
            remove_child(_high_lod)
        LOD.MEDIUM:
            remove_child(_med_lod)
        LOD.LOW:
            remove_child(_low_lod)

    # Add new LOD
    match new_lod:
        LOD.HIGH:
            add_child(_high_lod)
        LOD.MEDIUM:
            add_child(_med_lod)
        LOD.LOW:
            add_child(_low_lod)

    _cur_lod = new_lod
