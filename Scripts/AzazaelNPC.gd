extends NPC

@export var has_waited = false
@export var has_red_slip = false

@onready var azazel_texture:Texture = preload("res://media/npcs/azazael_texture_pixels.png")
@onready var sprite = $Sprite2D

var order = [
	0, 10, 2, 10, 3, 10, 5, 10, 4, 10
]

var order_index = 0

func _ready():
	dialogs = [
		"AzazaelMeet",    # 0
		"AzazaelWait",    # 1
		"AzazaelMeet2",   # 2
		"AzazaelMeet3",   # 3
		"AzazaelMeet4",   # 4
		"AzazaelZouk",    # 5
		"AzazaelRedSlip", # 6
		"AzazaelRedSlip2",# 7
		"AzazaelGift1",   # 8
		"AzazaelGifts",   # 9
		"AzazaelFiller"   # 10
	]
	sprite.texture =azazel_texture
	sprite.scale.x = 10.4
	sprite.scale.y = 10.4
	kiss = 30
	marry = 40
	kill = 30


func transition():
	if dialogIndex < 0:
		order_index = 0
	dialogIndex = order[order_index]
	order_index = min(order_index+1, order.size()-1)

func choose_gift():
	if firstGift:
		firstGift = false
		return dialogs[8]
	else:
		return dialogs[9]

func on_kiss():
	var proba = randi_range (0,100)
	if proba>kiss:
		refuse()
	else:
		PlayerStatCounter.azazael["kiss"]+=1
		self.start_dial("AzazaelAcceptKiss")
func on_marry():
	var proba = randi_range (0,100)
	if proba>marry:
		refuse()
	else:
		PlayerStatCounter.azazael["marry"]+=1
		self.start_dial("AzazaelAcceptMarry")
func on_kill():
	var kill_proba = randi_range (0,100)
	if kill_proba>kill:
		refuse()
	else:
		PlayerStatCounter.azazael["kill"]+=1
		self.start_dial("AzazaelAcceptKill")

func refuse():
	Dialogic.start("AzazaelRefuse")

func reset():
	
	kiss = 20
	marry = 30
	kill = 50
	
	PlayerStatCounter.azazael["kiss"]=0
	PlayerStatCounter.azazael["marry"]=0
	PlayerStatCounter.azazael["kill"]=0
	
	print("Azazael was reset")


func _on_cave_of_lost_souls_sig_azazael():
	reset()
