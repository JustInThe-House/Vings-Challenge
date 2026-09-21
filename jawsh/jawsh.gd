extends RigidBody3D

@export var roll_speed: float = 200.0
@export var sensitivity = 0.005
@export var JUMP_POWER := 1200.0
var CAN_MOVE := true

@onready var camera := $SpringArmPivot/Camera3D
@onready var camera_pivot := $SpringArmPivot
@onready var jump_timer := $JumpTimer
@onready var ground_check := $OnGroundCheck
@onready var jump_buffer := $JumpBuffer

func _physics_process(delta: float) -> void:
	#ball roll movement. Must be relative to the camera.
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if CAN_MOVE:
		if input_dir.y != 0.0:
			angular_velocity.x += input_dir.y * roll_speed * delta * cos(camera.global_rotation.y)
			angular_velocity.z -= input_dir.y * roll_speed * delta * sin(camera.global_rotation.y)
		if input_dir.x != 0.0:
			angular_velocity.x -= input_dir.x * roll_speed * delta * sin(camera.global_rotation.y)
			angular_velocity.z -= input_dir.x * roll_speed * delta * cos(camera.global_rotation.y)
		# may make it so you are slower to move in a direction when starting. this is so you dont immediately go fast, 
		#AND on controller you dont quickly move in a different direction because you cant hold your finger perfectly straight
		#print(angular_velocity)

	
		# jump
		var is_on_floor = ground_check.is_colliding()
		if Input.is_action_just_pressed("jump"):
			jump_buffer.start()
			
		if not jump_buffer.is_stopped() and not Input.is_action_pressed("fullscreen") and is_on_floor and jump_timer.is_stopped():
			# physics
			apply_central_force(Vector3.UP*JUMP_POWER)
			jump_timer.start()
			
			# sound effect
			UtilsSound.play_sound("res://jawsh/jump.wav", -10.0)
		
		#cooldown for jump
		if jump_timer.time_left > 0:
			if !is_on_floor and not jump_timer.paused:
				jump_timer.paused = true
			elif is_on_floor and jump_timer.paused:
				jump_timer.paused = false
