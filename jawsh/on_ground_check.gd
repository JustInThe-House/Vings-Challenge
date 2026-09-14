extends RayCast3D

func _physics_process(_delta: float) -> void:
	global_transform.origin = $"..".global_transform.origin
