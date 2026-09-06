extends Control

var can_end: bool = false

func _ready() -> void:
	Music.stop()
	$AnimationPlayer.current_animation = "youwin"
	

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("back")) and can_end:
		Music.stream = load("res://music/Ving's Challenge.ogg")
		SaveManager.save_data.beat_game = true
		SaveManager.write_to_save()
		get_tree().change_scene_to_file("res://menu/menu.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "youwin":
		can_end = true
	pass # Replace with function body.
