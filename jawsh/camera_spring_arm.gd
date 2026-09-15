extends SpringArm3D
@export var sensitivity = 0.005
@export var spring_arm_length: float = 5.5
const extra_pad_sensitivity_x = 720
const extra_pad_sensitivity_y = extra_pad_sensitivity_x * 0.5
var frozen := false

@onready var base := $".."

func _ready() -> void:
	spring_length = spring_arm_length
	global_position = base.global_position

func _unhandled_input(event: InputEvent) -> void:
	if not frozen:
		if event is InputEventMouseMotion:
			rotation.y -= event.relative.x * sensitivity
			rotation.y = wrapf(rotation.y, 0.0, TAU)
			rotation.x -= event.relative.y * sensitivity
			rotation.x = clamp(rotation.x, -PI/2, 0)

# probably need to set actual movement to be like keyboard, otherwise its really annoying to play (cant move in straight line!)
func _process(delta: float) -> void:
	if not frozen:
		global_position = base.global_position
		
		var camera_movement = Input.get_vector("camera_left","camera_right","camera_up","camera_down")
		rotation.y -= sensitivity * camera_movement.x * delta * extra_pad_sensitivity_x
		rotation.x -= sensitivity * camera_movement.y * delta * extra_pad_sensitivity_x
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		rotation.x = clamp(rotation.x, -PI/2, 0)
	
