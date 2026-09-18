extends MainMenuButton


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


func _process(delta: float) -> void:
	super(delta)
	if has_focus():
		if Input.is_action_pressed("move_right"):
			Universal.change_volume(0.01 * delta * 10.0)
		elif Input.is_action_pressed("move_left"):
			Universal.change_volume(-0.01 * delta * 10.0)
		text = "Volume: " + str(int(round(Universal.volume_perc * 100))) + "%" 

func back_button(event: InputEvent) -> void:
	%Back.pressed.emit()
	
