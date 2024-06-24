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

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   Constants

const GLOBAL_SENSITIVITY: float = 0.01
const X_SENSITIVITY: float = 0.9 * GLOBAL_SENSITIVITY
const Y_SENSITIVITY: float = 0.45 * GLOBAL_SENSITIVITY
const Y_ROT_MIN: float = deg_to_rad(-90)
const Y_ROT_MAX: float = deg_to_rad(90)
