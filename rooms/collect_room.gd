extends Node3D

@export var player: RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.global_position.y < -10:
		get_tree().change_scene_to_file("res://gameover/gameover.tscn")
