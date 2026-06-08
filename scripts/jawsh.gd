extends RigidBody3D

@export var roll_speed = 60
const MAX_ROLL_SPEED = 100
const JUMP = 20

@export var camera: Camera3D

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if Input.is_action_pressed("move_up"):
		angular_velocity.x -= roll_speed * delta * cos(camera.global_rotation.y)
		angular_velocity.z += roll_speed * delta * sin(camera.global_rotation.y)
	elif Input.is_action_pressed("move_down"):
		angular_velocity.x += roll_speed * delta * cos(camera.global_rotation.y)
		angular_velocity.z -= roll_speed * delta * sin(camera.global_rotation.y)
	if Input.is_action_pressed("move_left"):
		angular_velocity.z += roll_speed * delta * cos(camera.global_rotation.y)
		angular_velocity.x += roll_speed * delta * sin(camera.global_rotation.y)
	elif Input.is_action_pressed("move_right"):
		angular_velocity.z -= roll_speed * delta * cos(camera.global_rotation.y)
		angular_velocity.x -= roll_speed * delta * sin(camera.global_rotation.y)
		
	#print(angular_velocity.normalized())
		
	if Input.is_action_pressed("jump"):
		linear_velocity.y += JUMP
		#linear_velocity.x -= angular_velocity.x * sin(camera.global_rotation.y)
		#linear_velocity.z -= angular_velocity.z
