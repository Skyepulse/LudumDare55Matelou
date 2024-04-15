extends Control

const SPRITE_SCALE = 4
var panelContainer:HBoxContainer
var panelContainer2:HBoxContainer
var panels

# Called when the node enters the scene tree for the first time.
func _ready():
	panelContainer = $wings/VBoxContainer/HBoxContainer
	panels = panelContainer.get_children()
	for panel in panels:
		var sprite = panel.get_node("Sprite2D")
		sprite.set_scale(Vector2(SPRITE_SCALE, SPRITE_SCALE))
		var spriteSize = sprite.get_texture().get_size()*SPRITE_SCALE
		panel.set_custom_minimum_size(Vector2(spriteSize.x, spriteSize.y))
		sprite.set_position(Vector2(spriteSize.x/2, spriteSize.y/2))
	panelContainer2 = $wings/VBoxContainer/HBoxContainer2
	var panel = panelContainer2.get_node("Panel")
	var spr = panel.get_node("Sprite2D")
	spr.set_scale(Vector2(SPRITE_SCALE/2, SPRITE_SCALE/2))
	var spriteS = spr.get_texture().get_size()*SPRITE_SCALE/2
	panel.set_custom_minimum_size(Vector2(spriteS.x, spriteS.y))
	spr.set_position(Vector2(spriteS.x/2, spriteS.y/2))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_dash(dashNum:int):
	for i in range(panels.size()):
		var panel = panels[i]
		var sprite = panel.get_node("Sprite2D")
		if i < dashNum:
			sprite.modulate.a = 1.0
		else:
			sprite.modulate.a = 0.2

func update_souls(souls:int):
	var label = $wings/VBoxContainer/HBoxContainer2/Label
	label.text = str(souls)
