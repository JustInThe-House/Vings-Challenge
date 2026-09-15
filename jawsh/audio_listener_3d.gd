extends AudioListener3D

@export var camera: Camera3D

func _process(_delta: float) -> void:
	global_rotation = camera.global_rotation
	global_transform.origin = $"..".global_transform.origin
