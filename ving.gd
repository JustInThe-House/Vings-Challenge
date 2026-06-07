extends CharacterBody3D


@export var speed = 10.0

@onready var player = get_tree().get_first_node_in_group("Jawsh")


func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#if not player:
		#return
	#var direction = global_position.direction_to(player.global_position)
	#print(direction)
	#velocity = direction * speed
	global_position = global_position.move_toward(Vector3(0,0,0), delta * speed)
