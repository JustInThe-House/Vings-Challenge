extends Room

@onready var ving := %Ving
@onready var jawsh := %Jawsh

func _ready() -> void:
	super._ready()
	Music.play()

func _process(_delta: float) -> void:
	var distance: float = jawsh.position.distance_to(ving.position)
	if distance < CRT_effect_distance and SaveManager.save_data.shaders:
		CRT.material.set("shader_parameter/alpha", 0.6 * (1 - distance/CRT_effect_distance))
		CRT.material.set("shader_parameter/vinnette_outer_radius", 0.2 + 0.5 * (distance/CRT_effect_distance))
		pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_menu = preload("res://menu/pause/pause_menu.tscn").instantiate()
		Universal.game_paused.emit()
		add_child(pause_menu)
