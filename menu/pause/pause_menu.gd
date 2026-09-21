extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/Resume.grab_focus.call_deferred()
