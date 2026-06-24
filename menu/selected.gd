@tool
extends Label

var selected := false

var setting : LabelSettings = LabelSettings.new()
var time := 0.0
@export var OUTLINE_SPACING = 5
@export var OUTLINE_MIN = 12
const FONT_SIZE = 70
@export var OUTLINE_TIMESPEED = 5

func _ready() -> void:
	setting.outline_color = Color.GREEN
	setting.outline_size = 0
	setting.font_size = FONT_SIZE
	setting.font_color = Color(0.0, 0.439, 0.0, 1.0)
	label_settings = setting
	
	

func _process(delta: float) -> void:

	if selected == true:
		time += delta * OUTLINE_TIMESPEED
		setting.outline_size = OUTLINE_MIN + OUTLINE_SPACING - OUTLINE_SPACING * sin(time)
	else:
		setting.outline_size = 0
		
