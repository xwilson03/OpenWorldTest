extends Node
class_name MouseController
## Class for handling mouse motion.

var camera_x: float = 0
var camera_y: float = 0


func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Handle camera rotation via mouse movement
	if event is InputEventMouseMotion:
		# Update cumulative rotation, but clamp vertical values
		camera_x += -event.relative.x * Globals.X_SENSITIVITY
		camera_y += -event.relative.y * Globals.Y_SENSITIVITY
		camera_y = clamp(camera_y, Globals.Y_ROT_MIN, Globals.Y_ROT_MAX)
		
		# Emit camera values
		Globals.set_camera_x.emit(camera_x)
		Globals.set_camera_y.emit(camera_y)
