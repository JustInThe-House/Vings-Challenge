extends SpringArm3D

@export var sensitivity = 0.005
const extra_pad_sensitivity_x = 480
const extra_pad_sensitivity_y = 240

# Called every frame.  'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * sensitivity
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		rotation.x -= event.relative.y * sensitivity
		rotation.x = clamp(rotation.x, -PI/2, 0)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("camera_right"):
		rotation.y -= sensitivity * delta * extra_pad_sensitivity_x
	elif Input.is_action_pressed("camera_left"):
		rotation.y += sensitivity * delta * extra_pad_sensitivity_x
	rotation.y = wrapf(rotation.y, 0.0, TAU)
	if Input.is_action_pressed("camera_up"):
		rotation.x += sensitivity * delta * extra_pad_sensitivity_y
	elif Input.is_action_pressed("camera_down"):
		rotation.x -= sensitivity * delta * extra_pad_sensitivity_y
	rotation.x = clamp(rotation.x, -PI/2, 0)
