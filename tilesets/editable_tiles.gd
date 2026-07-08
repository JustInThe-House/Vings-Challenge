@tool
extends MeshInstance3D


func _process(delta: float) -> void:
	var num_of_tiles_x: float = mesh.size.x/4.0
	var num_of_tiles_z: float = mesh.size.z/4.0
	mesh.material.uv1_scale.x = 3.0 * num_of_tiles_x
	mesh.material.uv1_scale.y = 2.0 * num_of_tiles_z
	$StaticBody3D/CollisionShape3D.shape.size = mesh.size
	pass
