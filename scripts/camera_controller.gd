extends Node3D
class_name CameraController
## Class for handling camera orbiting; should be applied to the camera's pivot.

@export var min_follow_distance: float = 1.2
@export var max_follow_distance: float = 5.0
@export var distance_per_scroll: float = 0.1

var camera_spring: SpringArm3D

func _input(_event):
	if Input.is_action_just_pressed("zoom_in"):
		_on_zoom_in()
	elif Input.is_action_just_pressed("zoom_out"):
		_on_zoom_out()

func _ready():
	Globals.set_camera_y.connect(_on_set_camera_y)
	
	camera_spring = get_child(0)
	if camera_spring == null:
		print("Player: Unable to find Camera Spring node.")

func _on_set_camera_y(value: float):
	# Reset and update camera y rotation to prevent precision loss
	transform.basis = Basis()
	rotate_x(value)

func _on_zoom_in():
	var new_length = clamp(
		camera_spring.spring_length - distance_per_scroll,
		min_follow_distance,
		max_follow_distance
	)
	camera_spring.spring_length = new_length
	
func _on_zoom_out():
	var new_length = clamp(
		camera_spring.spring_length + distance_per_scroll,
		min_follow_distance,
		max_follow_distance
	)
	camera_spring.spring_length = new_length
