extends Control

var can_end: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.stop()
	$AnimationPlayer.current_animation = "jumpscare"
	await get_tree().create_timer(1.0).timeout
	can_end = true

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("jump") or event.is_action_pressed("back")) and can_end:
		get_tree().change_scene_to_file(Universal.main_menu_scene)
