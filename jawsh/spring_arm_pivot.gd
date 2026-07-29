extends Node3D

@onready var anchor = $"."
var frozen := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = $"..".global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not frozen:
		global_position = $"..".global_position
	pass
