extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/Resume.grab_focus.call_deferred()
	UtilsSound.play_sound("res://menu/ui_move.wav", -3.0)

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false
