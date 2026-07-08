extends Area3D

@export var speed: float
var scream_timer := 1.0
var fury := 1.1

func _process(delta: float) -> void:
	# MAKE THIS AN EMIT
	scream_timer += delta * (1 + fury * 1.5)
	if scream_timer > 1:
		scream_timer = 0.0
		$AudioStreamPlayer3D.pitch_scale = 1.0 + fury*0.5
		$AudioStreamPlayer3D.play()

func _physics_process(delta: float) -> void:
	#if player != null:
		pass
		#global_position = global_position.move_toward(player.global_position, delta * speed * (1 + fury * 0.45))
#	1.45% is probably the max he should go. though may have to factor in controller, which is a LOT harder

func _on_body_entered(body: RigidBody3D) -> void:
	get_tree().change_scene_to_file("res://gameover/gameover.tscn")
	pass # Replace with function body.
