extends Area3D

@export var speed: float
var player: RigidBody3D
var fury := 0.0
var scream_timer := 1.0

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	scream_timer += delta
	if scream_timer > 1:
		scream_timer = 0.0
		$AudioStreamPlayer3D.play()

func _physics_process(delta: float) -> void:
	if player != null:
		global_position = global_position.move_toward(player.global_position, delta * speed * (1 + fury * 0.45))
#	1.45% is probably the max he should go. though may have to factor in controller, which is a LOT harder

func _on_body_entered(body: RigidBody3D) -> void:
	get_tree().change_scene_to_file("res://gameover/gameover.tscn")
	pass # Replace with function body.
