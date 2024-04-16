extends NPC

@export var has_waited = false
@export var has_red_slip = false
@onready var texture:Texture = preload("res://media/npcs/dolore_texture_pixel.png")
@onready var sprite = $Sprite2D

var order = [
	0, 9, 1, 9, 2, 9, 3, 9, 4, 9
]

var order_index = 0

func _ready():
	dialogs = [
		"DoloreMeet", #0
		"DoloreMeet2",#1
		"DoloreMeet3",#2
		"DoloreMeet4",#3
		"DoloreMeet5",#4
		"DoloreClub", #5
		"DoloreUnion",#6
		"DoloreGift1",#7
		"DoloreGifts",#8
		"DoloreFiller"#9
	]
	sprite.texture =texture
	sprite.scale.x = 10.4
	sprite.scale.y = 10.4
	kiss = 20
	marry = 30
	kill = 50



func transition():
	if dialogIndex < 0:
		order_index = 0
	dialogIndex = order[order_index]
	order_index = min(order_index+1, order.size()-1)
		
func on_kiss():
	var proba = randi_range (0,100)
	if proba>kiss:
		Dialogic.start("DoloreRefuseKiss")
	else:
		PlayerStatCounter.dolore["kiss"]+=1
func on_marry():
	var proba = randi_range (0,100)
	if proba>marry:
		Dialogic.start("DoloreRefuseMarry")
	else:
		PlayerStatCounter.dolore["marry"]+=1
func on_kill():
	var proba = randi_range (0,100)
	if proba>kill:
		Dialogic.start("DoloreRefuseKill")
	else:
		PlayerStatCounter.dolore["kill"]+=1

func reset():
	kiss = 20
	marry = 30
	kill = 50
	
	PlayerStatCounter.dolore["kiss"]=0
	PlayerStatCounter.dolore["marry"]=0
	PlayerStatCounter.dolore["kill"]=0
	print("Dolore was reset")


func _on_cave_of_lost_souls_sig_dolore():
	reset()
