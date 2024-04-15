extends MarginContainer

func _ready():
	var margin_value = 50
	add_theme_constant_override("margin_top", margin_value)
	add_theme_constant_override("margin_left", margin_value)
	add_theme_constant_override("margin_bottom", margin_value/2)
	add_theme_constant_override("margin_right", margin_value)