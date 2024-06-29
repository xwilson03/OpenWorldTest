extends Node
class_name MouseController
## Class for handling mouse motion.

var camera_x: float = 0
var camera_y: float = 0


func _init() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
    # Handle camera rotation via mouse movement
    if event is InputEventMouseMotion:
        var mouse_event := event as InputEventMouseMotion

        # Update cumulative rotation, but clamp vertical values
        camera_x += -mouse_event.relative.x * Globals.X_SENSITIVITY
        camera_y += -mouse_event.relative.y * Globals.Y_SENSITIVITY
        camera_y = clamp(camera_y, Globals.Y_ROT_MIN, Globals.Y_ROT_MAX)

        # Emit camera values
        Globals.set_camera_x.emit(camera_x)
        Globals.set_camera_y.emit(camera_y)

    if Input.is_key_pressed(KEY_1):
        Globals.global_lod = Chunk.LOD.HIGH
        Globals.set_lod.emit(Chunk.LOD.HIGH)

    if Input.is_key_pressed(KEY_2):
        Globals.global_lod = Chunk.LOD.MEDIUM
        Globals.set_lod.emit(Chunk.LOD.MEDIUM)

    if Input.is_key_pressed(KEY_3):
        Globals.global_lod = Chunk.LOD.LOW
        Globals.set_lod.emit(Chunk.LOD.LOW)
