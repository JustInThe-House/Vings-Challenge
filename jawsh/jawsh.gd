extends RigidBody3D

@export var roll_speed: float
@export var sensitivity = 0.005
const MAX_ROLL_SPEED = 25
const JUMP_POWER = 1200

@onready var camera := $SpringArmPivot/SpringArm3D/Camera3D as Camera3D
@onready var camera_pivot := $SpringArmPivot as Node3D


func _physics_process(delta: float) -> void:
	#ball roll movement. Must be relative to the camera.
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
	if input_dir[0] == 0.0 and input_dir[1] == 0.0:
		angular_velocity.z = move_toward(angular_velocity.z, 0.0, delta)
		angular_velocity.x = move_toward(angular_velocity.x, 0.0, delta)
		
	# limit max rolling speed
	angular_velocity.x = clamp(angular_velocity.x, -MAX_ROLL_SPEED, MAX_ROLL_SPEED)
	angular_velocity.z = clamp(angular_velocity.z, -MAX_ROLL_SPEED, MAX_ROLL_SPEED)
	
	
	
	# jump
	var is_on_floor = $OnGroundCheck.is_colliding()
	if Input.is_action_just_pressed("jump") and not Input.is_action_pressed("fullscreen") and is_on_floor and $JumpTimer.is_stopped():
		# physics
		apply_central_force(Vector3.UP*JUMP_POWER)
		$JumpTimer.start()
		
		# sound effect
		UtilsSound.play_sound("res://jawsh/jump.wav", -10.0)
	
	#cooldown for jump
	if $JumpTimer.time_left > 0:
		if !is_on_floor and $JumpTimer.paused == false:
			$JumpTimer.paused = true
		elif is_on_floor and $JumpTimer.paused == true:
			$JumpTimer.paused = false
	

	
	
