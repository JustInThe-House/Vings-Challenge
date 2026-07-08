extends Node3D
	
func _ready() -> void:
	rotation.y = randf_range(0,2*PI)
	pass
	
func _physics_process(delta: float) -> void:
	rotation.y += PI * 0.5 * delta
	pass



func _on_body_entered(body: Node3D) -> void:
	UtilsSound.play_sound("res://ving doll/doll_collect.wav", -10.0)
	queue_free()
	
	
