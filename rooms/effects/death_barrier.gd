extends StaticBody3D

@export var player: RigidBody3D

signal game_over

func _on_body_entered(body: Node3D) -> void:
	if body == player:
		game_over.emit()
		# run gameover effect
