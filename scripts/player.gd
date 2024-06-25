extends CharacterBody3D
class_name Player
## Class for handling player movement

@export var speed: float = 14
@export var jump_speed: float = 1
@export var fall_acceleration: float = 3

var target_velocity := Vector3.ZERO
var chunk_position := Vector3.ZERO


func _init():
    Globals.set_camera_x.connect(_on_set_camera_x)

func _on_set_camera_x(value: float):
    # Reset and update player x rotation to prevent precision loss
    transform.basis = Basis()
    rotate_y(value)

func _physics_process(delta):
    # Zero movement vector
    var direction := Vector3.ZERO
    
    # Fetch movement vector components from user input
    if (Input.is_action_pressed("move_left")):
        direction.x -= 1;
    if (Input.is_action_pressed("move_right")):
        direction.x += 1;
    if (Input.is_action_pressed("move_forward")):
        direction.z -= 1;
    if (Input.is_action_pressed("move_back")):
        direction.z += 1;
    
    # Normalize direction vector
    if (direction != Vector3.ZERO):
        direction = direction.normalized()
    
    # Update horizontal velocity 
    target_velocity.x = direction.x
    target_velocity.z = direction.z
    
    # Update vertical velocity
    if (Input.is_action_pressed("jump") and is_on_floor()):
        target_velocity.y = jump_speed
    elif not is_on_floor():
        target_velocity.y -= fall_acceleration * delta
    
    # Transform local velocity to global velocity
    velocity = (transform.basis * target_velocity) * speed
    
    # Apply velocity
    move_and_slide()
    update_chunk_pos()

# Emit signal when crossing chunk boundaries
func update_chunk_pos():
    # Update position within current chunk
    chunk_position += get_position_delta()
    
    # Calculate chunk boundaries using globals
    var positive_bound: float = (Globals.chunk_size + Globals.chunk_boundary_tolerance)
    var negative_bound: float = -Globals.chunk_boundary_tolerance
    
    # X_POS
    if chunk_position.x >= positive_bound:
        chunk_position.x -= Globals.chunk_size
        Globals.entered_new_chunk.emit(Globals.DIRECTION.X_POS)
    
    # X_NEG
    elif chunk_position.x < negative_bound:
        chunk_position.x += Globals.chunk_size
        Globals.entered_new_chunk.emit(Globals.DIRECTION.X_NEG)
    
    # Z_POS
    if chunk_position.z >= positive_bound:
        chunk_position.z -= Globals.chunk_size
        Globals.entered_new_chunk.emit(Globals.DIRECTION.Z_POS)
    
    # Z_NEG
    elif chunk_position.z < negative_bound:
        chunk_position.z += Globals.chunk_size
        Globals.entered_new_chunk.emit(Globals.DIRECTION.Z_NEG)
