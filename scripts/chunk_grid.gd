class_name ChunkGrid

enum {
    TOP,
    LEFT,
    BOTTOM,
    RIGHT
}

const BUFFER_SIZE: int = 1
var _size: Vector2i

var _array: Array[Chunk] = []
var _bounds: Array[int] = []
var _offset: Vector2

var _parent_node: Node
var _chunk_scene: PackedScene = null
var _chunk_size: Vector2

func _init(
        parent_node: Node3D,
        size: Vector2i,
        chunk_scene: PackedScene,
        chunk_size: Vector2,
        pos_offset := Vector2.ZERO
    ) -> void:

    _parent_node = parent_node

    _size = size

    _chunk_scene = chunk_scene
    _chunk_size = chunk_size
    _offset = pos_offset - _chunk_size / 2.0

    _bounds.resize(4)
    _bounds[TOP] = 0
    _bounds[LEFT] = 0
    _bounds[BOTTOM] = _size.y - 1
    _bounds[RIGHT] = _size.x - 1

    _array.resize((_size.x + BUFFER_SIZE) * (_size.y + BUFFER_SIZE))

    for x in _size.x:
        for y in _size.y:
            _create_chunk(x, y)

    Globals.player_xz.connect(_on_player_xz)

func _out_of_bounds(x: int, y: int) -> bool:
    if (x < _bounds[LEFT] or x > _bounds[RIGHT]
     or y < _bounds[TOP] or y > _bounds[BOTTOM]):
        push_error("ChunkGrid: Array index out of bounds: (", x, ", ", y, ")")
        return true
    return false

func _wrapped_idx(x: int, y: int) -> int:
        x = x % (_size.x + BUFFER_SIZE)
        y = y % (_size.y + BUFFER_SIZE)

        return y * (_size.x + BUFFER_SIZE) + x

func _world_pos(x: int, y: int) -> Vector3:
    return Vector3(
        ((_bounds[RIGHT] - _bounds[LEFT] + 1) / 2.0 - x) * _chunk_size.x + _offset.x,
        0,
        ((_bounds[BOTTOM] - _bounds[TOP] + 1) / 2.0 - y) * _chunk_size.y + _offset.y
    )

func _create_chunk(x: int, y: int) -> void:
    if (_out_of_bounds(x, y)):
        return

    var chunk: Chunk = _chunk_scene.instantiate()
    chunk.translate(_world_pos(x, y))

    _array[_wrapped_idx(x, y)] = chunk
    _parent_node.add_child(chunk)

func _delete_chunk(x: int, y: int) -> void:
    if (_out_of_bounds(x, y)):
        return

    var chunk: Chunk = _array[_wrapped_idx(x, y)]
    _parent_node.remove_child(chunk)
    chunk.queue_free()

func _add_column(x: int) -> void:
    for i in range(_bounds[TOP], _bounds[BOTTOM] + 1):
        _create_chunk(x, i)

func _add_row(y: int) -> void:
    for i in range(_bounds[LEFT], _bounds[RIGHT] + 1):
        _create_chunk(i, y)

func _delete_column(x: int) -> void:
    for i in range(_bounds[TOP], _bounds[BOTTOM] + 1):
        _delete_chunk(x, i)

func _delete_row(y: int) -> void:
    for i in range(_bounds[LEFT], _bounds[RIGHT] + 1):
        _delete_chunk(i, y)

func _on_player_xz(pos: Vector2) -> void:

    var center := Vector2(
        -((_bounds[RIGHT] + _bounds[LEFT] + 1 - _size.x) / 2) * _chunk_size.x + _offset.x,
        -((_bounds[BOTTOM] + _bounds[TOP] + 1 - _size.y) / 2) * _chunk_size.y + _offset.y
    )

    if (pos.x > center.x + _chunk_size.x):
        _move(Globals.DIRECTION.X_POS)
    elif (pos.x < center.x - _chunk_size.x):
        _move(Globals.DIRECTION.X_NEG)

    if (pos.y > center.y + _chunk_size.y):
        _move(Globals.DIRECTION.Z_POS)
    elif (pos.y < center.y - _chunk_size.y):
        _move(Globals.DIRECTION.Z_NEG)

func _move(direction: Globals.DIRECTION) -> void:
    match direction:

        Globals.DIRECTION.X_POS:
            _delete_column(_bounds[RIGHT])
            _bounds[LEFT] -= 1
            _bounds[RIGHT] -= 1
            _add_column(_bounds[LEFT])

        Globals.DIRECTION.X_NEG:
            _delete_column(_bounds[LEFT])
            _bounds[RIGHT] += 1
            _bounds[LEFT] += 1
            _add_column(_bounds[RIGHT])

        Globals.DIRECTION.Z_POS:
            _delete_row(_bounds[BOTTOM])
            _bounds[TOP] -= 1
            _bounds[BOTTOM] -= 1
            _add_row(_bounds[TOP])

        Globals.DIRECTION.Z_NEG:
            _delete_row(_bounds[TOP])
            _bounds[BOTTOM] += 1
            _bounds[TOP] += 1
            _add_row(_bounds[BOTTOM])
