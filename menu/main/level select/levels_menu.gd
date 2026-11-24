extends GridContainer
# could set button names based on panel names, in case i change things

@onready var last_focus: MainMenuButton = $Back/Back

var left_pressed := false
var right_pressed := false
var up_pressed := false
var down_pressed := false

func _ready() -> void:
	$Back/Back.pressed.connect(_on_back_pressed)

func _on_extra_pressed() -> void:
	visible = true
	last_focus.grab_focus.call_deferred()

func _on_back_pressed() -> void:
	menu_off()

func menu_off() -> void:
	last_focus = get_viewport().gui_get_focus_owner()
	print(last_focus)
	visible = false
