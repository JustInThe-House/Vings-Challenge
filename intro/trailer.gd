extends Node2D

func _ready() -> void:
	$AnimationPlayer.current_animation = "trailer"

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")
	pass # Replace with function body.
# need to add flash between both. maybe just do in menu?


func play_music() -> void:
	Music.play()
