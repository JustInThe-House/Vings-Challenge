extends Node

signal plushie_collected

@onready var state := GameState.ACTIVE

enum GameState {
	ACTIVE,
	FROZEN,
	PAUSED
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
