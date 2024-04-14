extends Control

var panelContainer:HBoxContainer
var panels
# Called when the node enters the scene tree for the first time.
func _ready():
	panelContainer = $wings/HBoxContainer
	panels = panelContainer.get_children()
	for panel in panels:
		var sprite = panel.get_node("Sprite2D")
		var spriteSize = sprite.get_texture().get_size()
		panel.set_custom_minimum_size(Vector2(spriteSize.x, spriteSize.y))
		sprite.set_position(Vector2(spriteSize.x/2, spriteSize.y/2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
