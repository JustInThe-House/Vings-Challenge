extends ShapeCast3D

@onready var base := $".."

func _ready() -> void:
	top_level = true

func _process(_delta: float) -> void:
	global_transform.origin = base.global_transform.origin
