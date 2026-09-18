extends Area3D

@export var speed: float
@export var player: RigidBody3D
@export var random_spawn: bool = false

@onready var sprite := $Sprite3D
@onready var scream := $AudioStreamPlayer3D
@onready var collision := $CollisionShape3D
var fury: float = 0.0
var scream_timer := 0.0

func _ready() -> void:
	if random_spawn and player:
		var distance_radius = 150
		var theta = randf_range(0, 2*PI)
		position.x = player.position.x + distance_radius*cos(theta)
		position.z = player.position.z + distance_radius*sin(theta)

func _process(delta: float) -> void:
	scream_timer += delta * (1 + fury * 1.5)
	if scream_timer > 1.25: # was 1
		scream_timer = 0.0
		scream.pitch_scale = (speed / 10.0) * (1 + fury * 0.5)
		scream.play()
		
	# move ving toward player. to make controller at least playable, make it slower
	if player:
		global_position = global_position.move_toward(player.global_position, delta * speed * (1 + fury * 0.5) * (1 - float(Universal.on_controller) * 0.2))

func _on_body_entered(_body: RigidBody3D) -> void:
	get_tree().change_scene_to_file(Universal.game_over_scene)
	pass # Replace with function body.
