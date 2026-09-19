extends VBoxContainer

@onready var last_focus: MainMenuButton = $Volume

var left_pressed := false
var right_pressed := false
var up_pressed := false
var down_pressed := false

func _ready() -> void:
	visible = false

func _on_settings_pressed() -> void:
	visible = true
	last_focus.grab_focus.call_deferred()

#func _gui_input(event: InputEvent) -> void:
	#if event.is_action_pressed("back"):
		#menu_off()
		

func _on_back_pressed() -> void:
	menu_off()

func menu_off() -> void:
	last_focus = get_viewport().gui_get_focus_owner()
	print(last_focus)
	visible = false
