extends Label


var setting : LabelSettings = LabelSettings.new()
var time := 0.0
@export var SIZE_AMPLITUDE = 5
var FONT_SIZE = 108
@export var SIZE_TIMESPEED = 3

func _ready() -> void:
	setting.font_size = FONT_SIZE
	setting.font_color = Color(0.0, 0.439, 0.0, 1.0)
	label_settings = setting


func _process(delta: float) -> void:
	time += delta * SIZE_TIMESPEED
	scale = Vector2(1.0 + pow(cos(time),2)*0.3, 1.0 + pow(cos(time),2)*0.0625) 
	rotation = sin(time)/8
