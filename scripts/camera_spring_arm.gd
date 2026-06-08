extends SpringArm3D

@export var mouse_sensitivity = 0.005

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sensitivity
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		rotation.x -= event.relative.y * mouse_sensitivity
		rotation.x = clamp(rotation.x, -PI/2, 0)
