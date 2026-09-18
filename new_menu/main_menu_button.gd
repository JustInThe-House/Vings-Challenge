class_name MainMenuButton extends Button
# not using the base button's change focus -- if nothing is assigned it still can change focus to something else.
# i also had to remove all of the ui controls in the input mapping. annoying, but not that big a deal.

## Sends focus to another button. does not require a button; if none is provided, you could use the direction to control something else.
@export_group("Send Focus")
@export var focus_left: MainMenuButton
@export var focus_right: MainMenuButton
@export var focus_up: MainMenuButton
@export var focus_down: MainMenuButton
@export_group("")

@onready var manager: Container = self.get_parent()

## Controls behavior of button's font's outline when in focus.
@export_group("Font Outline")
var outline_time := 0.0
@export var outline_speed := 6.0
@export var outline_variance := 6.0
@export var outline_base := 38.0
@export_group("")

#if extending, need to use super()
func _process(delta: float) -> void:
	if has_focus():
		outline_time += delta * outline_speed
		add_theme_constant_override("outline_size", outline_base + outline_variance * sin(outline_time))
	else:
		add_theme_constant_override("outline_size", 0)
		pass
		
func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up") and focus_up and not manager.up_pressed:
		focus_up.grab_focus.call_deferred()
		UtilsSound.play_sound("res://menu/ui_move.wav", -3.0)
		manager.up_pressed = true
	elif event.is_action_pressed("move_down") and focus_down and not manager.down_pressed:
		focus_down.grab_focus.call_deferred()
		UtilsSound.play_sound("res://menu/ui_move.wav", -3.0)
		manager.down_pressed = true
	elif event.is_action_pressed("move_left") and focus_left and not manager.left_pressed:
		focus_left.grab_focus.call_deferred()
		UtilsSound.play_sound("res://menu/ui_move.wav", -3.0)
		manager.left_pressed = true
	elif event.is_action_pressed("move_right") and focus_right and not manager.right_pressed:
		focus_right.grab_focus.call_deferred()
		UtilsSound.play_sound("res://menu/ui_move.wav", -3.0)
		manager.right_pressed = true
	if event.is_action_pressed("jump"):
		press_button(event)
		UtilsSound.play_sound("res://menu/ui_confirm.wav", -3.0)
	if event.is_action_pressed("back"):
		back_button(event)
	
	if event.is_action_released("move_up"):
		manager.up_pressed = false
	if event.is_action_released("move_down"):
		manager.down_pressed = false
	if event.is_action_released("move_left"):
		manager.left_pressed = false
	if event.is_action_released("move_right"):
		manager.right_pressed = false
	
	
## Runs when player presses confirm while on this button.
func press_button(_event: InputEvent) -> void:
	pass
	
## Runs when player presses back while on this button.
func back_button(_event: InputEvent) -> void:
	pass
		
