extends Node3D
class_name Chunk

@export var _lod: Globals.LOD
@export var _this: Node3D
@export var _children: Array[Chunk]

var _showing_children: bool

func _ready() -> void:
    for child in _children:
        remove_child(child)
    _showing_children = false

    if (Globals.lod_ranges[_lod] > 0):
        Globals.player_xz.connect(_on_player_xz)

func _on_player_xz(pos: Vector2) -> void:
    if !is_inside_tree():
        return

    var dist_to_player: float = (pos - (Vector2(global_position.x, global_position.z))).length()
    if dist_to_player <= Globals.lod_ranges[_lod]:
        _show_children()
    else:
        _show_self()

func _show_children() -> void:
    if _showing_children:
        return

    remove_child(_this)
    for child in _children:
        add_child(child)
    _showing_children = true

func _show_self() -> void:
    if not _showing_children:
        return

    for child in _children:
        remove_child(child)
    add_child(_this)
    _showing_children = false
