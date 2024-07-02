extends Node3D
class_name Chunk

@export var _lod: Globals.LOD
@export var _this: Node3D
@export var _children: Array[Node3D]

var _showing_children: bool

func _ready() -> void:
    for chunk in _children:
        remove_child(chunk)
    _showing_children = false

    Globals.player_xz.connect(_on_player_xz)

func _on_player_xz(pos: Vector2) -> void:
    var dist_to_player: float = (pos - Vector2(position.x, position.z)).length()
    if dist_to_player <= Globals.lod_ranges[_lod] and not _showing_children:
        _show_children()
    else:
        _show_self()

func _show_children() -> void:
    remove_child(_this)
    for child in _children:
        add_child(child)
    _showing_children = true

func _show_self() -> void:
    for child in _children:
        remove_child(child)
    add_child(_this)
    _showing_children = false
