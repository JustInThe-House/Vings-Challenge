extends Control

var can_end: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.stop()
	$AnimationPlayer.current_animation = "jumpscare"
	await get_tree().create_timer(1.0).timeout
	can_end = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("back")) and can_end:
		get_tree().change_scene_to_file("res://menu/menu.tscn")
