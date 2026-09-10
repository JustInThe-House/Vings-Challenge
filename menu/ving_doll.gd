extends MeshInstance3D

func _process(delta: float) -> void:
	rotation.y += PI * 0.5 * delta
