class_name MenuItem

extends Control

const COLOR_SELECTED = Color(1.0, 1.0, 1.0, 1.0)
const COLOR_UNSELECTED = Color(0.5, 0.5, 0.5, 1.0)

func _ready():
	modulate = COLOR_UNSELECTED


func selected(is_true: bool):
	modulate = COLOR_SELECTED if is_true else COLOR_UNSELECTED
