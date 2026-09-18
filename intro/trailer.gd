extends Node2D

func _ready() -> void:
	$AnimationPlayer.current_animation = "trailer"

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(Universal.main_menu_scene)

func play_music() -> void:
	Music.play()
