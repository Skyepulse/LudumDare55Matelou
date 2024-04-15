extends NPC

@export var has_waited = false
@export var has_red_slip = false

@onready var azazel_texture:Texture = preload("res://media/npcs/azazael_texture_pixels.png")
@onready var sprite = $Sprite2D

func _ready():
	dialogs = [
		"AzazaelMeet", # 0
		"AzazaelWait", # 1
		"AzazaelMeet2",# 2
		"AzazaelMeet3",# 3
		"AzazaelZouk", # 4
		"RedSlip",     # 5
		"RedSlip2"     # 6
	]
	sprite.texture =azazel_texture
	sprite.scale.x = 10.4
	sprite.scale.y = 10.4
	kiss = 70
	marry = 10
	kill = 10


func transition():
	if dialogIndex < 0:
		dialogIndex = 0
	elif dialogIndex == 0:
		dialogIndex = 1
	elif dialogIndex == 1:
		if has_waited:
			dialogIndex = 2
		else:
			dialogIndex = 1
	elif dialogIndex == 2:
		dialogIndex = 3

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
	
