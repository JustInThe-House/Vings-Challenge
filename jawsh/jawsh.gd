extends RigidBody3D

@export var roll_speed: float = 200.0
@export var sensitivity = 0.005
const MAX_ROLL_SPEED := 35.0
@export var JUMP_POWER := 1200.0
var CAN_MOVE := true

@onready var camera := $SpringArmPivot/SpringArm3D/Camera3D as Camera3D
@onready var camera_pivot := $SpringArmPivot as Node3D
@onready var jump_timer := $JumpTimer
@onready var ground_check := $OnGroundCheck


func _physics_process(delta: float) -> void:
	#ball roll movement. Must be relative to the camera.
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if CAN_MOVE:
		if not Universal.on_controller:
			#allows for good feeling diagonals in keyboard mode
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
		else:
			# allows for controllability in controller mode. somehow slows diagonal movement? idk, its fine
			if input_dir.y != 0.0:
				angular_velocity.x += input_dir.y * roll_speed * delta * cos(camera.global_rotation.y)
				angular_velocity.z -= input_dir.y * roll_speed * delta * sin(camera.global_rotation.y)
			if input_dir.x != 0.0:
				angular_velocity.x -= input_dir.x * roll_speed * delta * sin(camera.global_rotation.y)
				angular_velocity.z -= input_dir.x * roll_speed * delta * cos(camera.global_rotation.y)
			if input_dir.x == 0.0 and input_dir.y == 0.0:
				angular_velocity.z = move_toward(angular_velocity.z, 0.0, delta)
				angular_velocity.x = move_toward(angular_velocity.x, 0.0, delta)
		
		# limit max rolling speed
		angular_velocity.x = clamp(angular_velocity.x, -MAX_ROLL_SPEED, MAX_ROLL_SPEED)
		angular_velocity.z = clamp(angular_velocity.z, -MAX_ROLL_SPEED, MAX_ROLL_SPEED)
		#print(angular_velocity)
	
	
	
		# jump
		var is_on_floor = ground_check.is_colliding()
		if Input.is_action_just_pressed("jump") and not Input.is_action_pressed("fullscreen") and is_on_floor and jump_timer.is_stopped():
			# physics
			apply_central_force(Vector3.UP*JUMP_POWER)
			jump_timer.start()
			
			# sound effect
			UtilsSound.play_sound("res://jawsh/jump.wav", -10.0)
		
		#cooldown for jump
		if jump_timer.time_left > 0:
			if !is_on_floor and jump_timer.paused == false:
				jump_timer.paused = true
			elif is_on_floor and jump_timer.paused == true:
				jump_timer.paused = false
				

	
	
