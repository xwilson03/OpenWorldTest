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

    Globals.player_xz.connect(_on_player_xz)

func _on_player_xz(pos: Vector2) -> void:
    var dist_to_player: float = (pos - Vector2(position.x, position.z)).length()

    if (dist_to_player <= Globals.high_lod_distance):
        set_lod(LOD.HIGH)
    elif (dist_to_player <= Globals.medium_lod_distance):
        set_lod(LOD.MEDIUM)
    else:
        set_lod(LOD.LOW)

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
