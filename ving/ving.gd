extends CharacterBody3D

@export var speed: float
@export var player: RigidBody3D
var scream_timer := 1.0

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	scream_timer += delta
	if scream_timer > 1:
		scream_timer = 0.0
		$AudioStreamPlayer3D.play()

func _physics_process(delta: float) -> void:
	#if enabled:
	global_position = global_position.move_toward(player.global_position, delta * speed)


#func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body is PlayerCharacter:
		#get_tree().change_scene_to_file("res://scenes/gameover.tscn")
