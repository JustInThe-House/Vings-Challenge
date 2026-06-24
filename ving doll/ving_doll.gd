extends Node3D

signal collected

@onready var game_manager = %GameManager # isnt great because this force connects the two scenes. id prefer an emit

	
func _ready() -> void:
	rotation.y = randf_range(0,2*PI)
	pass
	
func _physics_process(delta: float) -> void:
	rotation.y += PI * 0.5 * delta
	pass
	
func collect():
	collected.emit()
	UtilsSound.play_sound("res://ving doll/doll_collect.wav", -10.0)
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	game_manager.add_point()
	collect()
	
	
