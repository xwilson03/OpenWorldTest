extends Node3D
class_name Chunk

@export var _high_lod_parent: Node3D
@export var _high_lod: Array[Node3D]
@export var _med_lod_parent: Node3D
@export var _med_lod: Array[Node3D]
@export var _low_lod_parent: Node3D
@export var _low_lod: Node3D

var _cur_lod: LOD

enum LOD {
    HIGH,
    MEDIUM,
    LOW,
}

func _ready() -> void:
    for chunk in _high_lod:
        _high_lod_parent.remove_child(chunk)
    for chunk in _med_lod:
        _med_lod_parent.remove_child(chunk)
    _cur_lod = LOD.LOW

    Globals.player_xz.connect(_on_player_xz)

func _on_player_xz(pos: Vector2) -> void:
    var dist_to_player: float = (pos - Vector2(position.x, position.z)).length()

    dist_to_player -= Globals.high_lod_distance
    if (dist_to_player <= 0):
        set_lod(LOD.HIGH)
        return

    dist_to_player -= Globals.medium_lod_distance
    if (dist_to_player <= 0):
        set_lod(LOD.MEDIUM)
        return

    set_lod(LOD.LOW)

func set_lod(new_lod: LOD) -> void:

    if new_lod == _cur_lod:
        return

    # Remove current LOD
    match _cur_lod:
        LOD.HIGH:
            for chunk in _high_lod:
                _high_lod_parent.remove_child(chunk)
        LOD.MEDIUM:
            for chunk in _med_lod:
                _med_lod_parent.remove_child(chunk)
        LOD.LOW:
            remove_child(_low_lod)

    # Add new LOD
    match new_lod:
        LOD.HIGH:
            for chunk in _high_lod:
                _high_lod_parent.add_child(chunk)
        LOD.MEDIUM:
            for chunk in _med_lod:
                _med_lod_parent.add_child(chunk)
        LOD.LOW:
            add_child(_low_lod)

    _cur_lod = new_lod
