extends KinematicBody

onready var Camera = $Pivot/Camera

var GRAVITY = -30
var MAXSPEED = 8
var MOUSE_SENSITIVITY = 0.002
var MOUSE_RANGE = 1.2

var velocity = Vector3()

func get_input():
	
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("foward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x

	input_dir = input_dir.normalized()
	return input_dir
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -MOUSE_RANGE, MOUSE_RANGE)
		
func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	var desired_velocity = get_input() * MAXSPEED
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
