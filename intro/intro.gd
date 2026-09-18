extends Control


func _ready() -> void:
	$AnimationPlayer.current_animation = "intro"


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if SaveManager.save_data.first_time_playing:
		get_tree().change_scene_to_file("res://intro/trailer.tscn")
	else:
		get_tree().change_scene_to_file(Universal.main_menu_scene)
	pass # Replace with function body.
