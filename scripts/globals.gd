extends Node
class_name Globals

# Singleton
static var instance := Globals.new()

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   Signals

# Camera (Private/Instanced)
signal _set_camera_x(value: float)
signal _set_camera_y(value: float)
signal _set_camera_dist(value: float)

# Camera (Public/Static)
static var set_camera_x := Signal(instance._set_camera_x)
static var set_camera_y := Signal(instance._set_camera_y)
static var set_camera_dist := Signal(instance._set_camera_dist)

# Player (Private/Instanced)
signal _player_xz(pos: Vector2)

# Player (Public/Static)
static var player_xz := Signal(instance._player_xz)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   Variables

# World Generation
static var world_radius: int = 0
static var chunk_size: float = 0
static var lod_ranges: Array[int] = []

# Mouse Sensitivity
const GLOBAL_SENSITIVITY: float = 0.01
const X_SENSITIVITY: float = 0.9 * GLOBAL_SENSITIVITY
const Y_SENSITIVITY: float = 0.45 * GLOBAL_SENSITIVITY
const Y_ROT_MIN: float = deg_to_rad(-90)
const Y_ROT_MAX: float = deg_to_rad(90)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   Enums

enum DIRECTION {
    X_POS,
    X_NEG,
    Z_POS,
    Z_NEG,
}

enum LOD {
    HIGH,
    MEDIUM,
    LOW,
}
