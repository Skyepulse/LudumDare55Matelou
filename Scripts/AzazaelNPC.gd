extends NPC

@export var has_waited = false
@export var has_red_slip = false

@onready var azazel_texture:Texture = preload("res://media/npcs/azazael_texture_pixels.png")
@onready var sprite = $Sprite2D

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
	kiss = 0
	marry = 0
	kill = 0


func transition():
	if dialogIndex < 0:
		dialogIndex = 0
		return
	
	if randi()%3 == 0: # Actual dialog
		pass
	else: # filler 
		pass
	
	if dialogIndex == 0:
		dialogIndex = 1
	elif dialogIndex == 1:
		if has_waited:
			dialogIndex = 2
		else:
			dialogIndex = 1
	elif dialogIndex == 2:
		dialogIndex = 3

func gift():
	if firstGift:
		firstGift = false
		return dialogs[8]
	else:
		return dialogs[9]

func on_kiss():
	if dialogIndex == 0 or dialogIndex == 1:
		refuse()
	else:
		PlayerStatCounter.azazael["kiss"]+=1
func on_marry():
	if dialogIndex == 0 or dialogIndex == 1:
		refuse()
	else:
		PlayerStatCounter.azazael["marry"]+=1
func on_kill():
	if dialogIndex == 0 or dialogIndex == 1:
		refuse()
	else:
		PlayerStatCounter.azazael["kill"]+=1

func refuse():
	Dialogic.start("AzazaelRefuse")
	
