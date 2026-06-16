extends Node3D

signal collected

@onready var game_manager = %GameManager # isnt great because this force connects the two scenes. id prefer an emit

	
func _ready() -> void:
	rotation.y = randf_range(0,2*PI)
	
func _physics_process(delta: float) -> void:
	rotation.y += 0.02
	
func collect():
	collected.emit()
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	game_manager.add_point()
	collect()
	
	
