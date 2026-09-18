extends MainMenuButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus.call_deferred()
	#call_deferred("grab_focus")
	#focus_mode = 
	print(has_focus())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
