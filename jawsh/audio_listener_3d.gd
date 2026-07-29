extends AudioListener3D

@export var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	global_rotation = camera.global_rotation
	global_transform.origin = $"..".global_transform.origin
