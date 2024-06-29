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

# World (Private/Instanced)
signal _entered_new_chunk(direction: DIRECTION)
signal _set_lod(lod: Chunk.LOD)

# World (Public/Static)
static var entered_new_chunk := Signal(instance._entered_new_chunk)
static var set_lod := Signal(instance._set_lod)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   Variables

# World Generation
static var world_radius: int = 0
static var chunk_size: float = 0
static var chunk_boundary_tolerance: float = 0
static var global_lod: Chunk.LOD = Chunk.LOD.HIGH

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
