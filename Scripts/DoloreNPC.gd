extends NPC

@export var has_waited = false
@export var has_red_slip = false
@onready var texture:Texture = preload("res://media/npcs/dolore_texture_pixel.png")
@onready var sprite = $Sprite2D

func _ready():
	dialogs = [
		"DoloreMeet"
	]
	sprite.texture =texture
	sprite.scale.x = 10.4
	sprite.scale.y = 10.4
	kiss = 20
	marry = 30
	kill = 50


func transition():
	if dialogIndex < 0:
		dialogIndex = 0
