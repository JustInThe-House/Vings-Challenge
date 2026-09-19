extends VBoxContainer

@onready var last_focus: MainMenuButton = $Play

var left_pressed := false
var right_pressed := false
var up_pressed := false
var down_pressed := false

func _on_settings_pressed() -> void:
	last_focus = get_viewport().gui_get_focus_owner()
	print(last_focus)
	visible = false


func _on_back_pressed() -> void:
	visible = true
	last_focus.grab_focus.call_deferred()
