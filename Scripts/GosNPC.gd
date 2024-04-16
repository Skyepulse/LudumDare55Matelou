extends NPC

@export var has_waited = false
@export var has_red_slip = false

@onready var texture:Texture = preload("res://media/npcs/gos_texture_pixel.png")
@onready var sprite = $Sprite2D

var order = [
	0, 10, 2, 10, 3, 10, 5, 10, 4, 10
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
	var proba = randi_range (0,100)
	if proba>kiss:
		Dialogic.start("GosRefuseKiss")
	else:
		PlayerStatCounter.gos["kiss"]+=1
func on_marry():
	var proba = randi_range (0,100)
	if proba>marry:
		Dialogic.start("GosRefuseMarry")
	else:
		PlayerStatCounter.gos["marry"]+=1
func on_kill():
	var proba = randi_range (0,100)
	if proba>kill:
		Dialogic.start("GosRefuseKill")
	else:
		PlayerStatCounter.gos["kill"]+=1

func refuse():
	Dialogic.start("AzazaelRefuse")
	
func reset():
	kiss = 20
	marry = 30
	kill = 50
	
	PlayerStatCounter.gos["kiss"]=0
	PlayerStatCounter.gos["marry"]=0
	PlayerStatCounter.gos["kill"]=0
	print("Gos was reset")


func _on_cave_of_lost_souls_sig_gos():
	reset()
