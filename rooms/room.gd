class_name Room extends Node3D

@onready var plushies := %Plushies
var plushies_collected: int = 0
var total_plushies: int
@export var next_scene: PackedScene
@onready var plushies_left_text := %PlushiesLeft
@onready var CRT: ColorRect = %CRT
@export var CRT_effect_distance := 80.0

func _ready() -> void:
	total_plushies = plushies.get_child_count()
	
	Game.plushie_collected.connect(_on_plushie_collected)
	plushies_left_text.text = "Plushies Left: " + str(total_plushies - plushies_collected)

func _on_plushie_collected() -> void:
	plushies_collected += 1
	plushies_left_text.text = "Plushies Left: " + str(total_plushies - plushies_collected)
	if total_plushies == plushies_collected:
		print(plushies_collected)
		if next_scene:
			get_tree().change_scene_to_packed(next_scene)
