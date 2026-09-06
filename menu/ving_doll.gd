extends MeshInstance3D

func _physics_process(delta: float) -> void:
	rotation.y += PI * 0.5 * delta
