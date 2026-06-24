extends Control


func _ready() -> void:
	$AnimationPlayer.current_animation = "intro"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")
	pass # Replace with function body.
