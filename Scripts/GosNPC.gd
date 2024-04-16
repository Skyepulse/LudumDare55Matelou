extends NPC

@export var has_waited = false
@export var has_red_slip = false

@onready var texture:Texture = preload("res://media/npcs/gos_texture_pixel.png")
@onready var sprite = $Sprite2D

var order = [
	0, 4, 1, 4, 2, 4, 3, 4
]

var order_index = 0

func _ready():
	dialogs = [
		"GosMeet", # 0
		"GosMeet2", # 1
		"GosMeet3",# 2
		"GosMeet4",# 3
		"GosFiller", # 4
		"GosGift1",     # 5
		"GosGifts"     # 6
	]
	sprite.texture =texture
	sprite.scale.x = 10.4
	sprite.scale.y = 10.4
	kiss = 20
	marry = 20
	kill = 20


func transition():
	if dialogIndex < 0:
		order_index = 0
	dialogIndex = order[order_index]
	order_index = min(order_index+1, order.size()-1)

func on_kiss():
	if dialogIndex == 0:
		Dialogic.start("GosRefuseKiss")
	else:
		PlayerStatCounter.gos["kiss"]+=1
func on_marry():
	if dialogIndex == 0:
		Dialogic.start("GosRefuseMarry")
	else:
		PlayerStatCounter.gos["marry"]+=1
func on_kill():
	if dialogIndex == 0:
		Dialogic.start("GosRefuseKill")
	else:
		PlayerStatCounter.gos["kill"]+=1
