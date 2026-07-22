extends Area3D

@export var speed: float
@export var player: RigidBody3D
@export var chase: bool = false
var fury: float = 0.0
var scream_timer := 1.0

func _ready() -> void:
	if not chase:
		var distance_radius = 150
		var theta = randf_range(0, 2*PI)
		position.x = player.position.x + distance_radius*cos(theta)
		position.z = player.position.z + distance_radius*sin(theta)
	pass # Replace with function body.

func _process(delta: float) -> void:
	# MAKE THIS AN EMIT
	scream_timer += delta * (1 + fury * 1.5)
	if scream_timer > 1:
		scream_timer = 0.0
		$AudioStreamPlayer3D.pitch_scale = (speed / 10.0) * (1 + fury * 0.5)
		$AudioStreamPlayer3D.play()

func _physics_process(delta: float) -> void:
	if player != null:
		global_position = global_position.move_toward(player.global_position, delta * speed * (1 + fury * 0.5))
#	50% is probably the max he should go. though may have to factor in controller, which is a LOT harder

func _on_body_entered(body: RigidBody3D) -> void:
	get_tree().change_scene_to_file("res://gameover/gameover.tscn")
	pass # Replace with function body.
