extends Node2D

var most_kiss : String = "azazael"
var most_kill : String = "gos"
var most_marry : String = "dolore"


@onready var kiss_az:Texture = preload("res://media/npcs/angel.png")
@onready var kill_az:Texture = preload("res://media/npcs/azazael_kill.png")
@onready var marry_az:Texture = preload("res://media/npcs/blushing_azazael.png")


@onready var kiss_gos:Texture = preload("res://media/npcs/scottish_demon.png")
@onready var kill_gos:Texture = preload("res://media/npcs/goskaeiroanez_kill.png")
@onready var marry_gos:Texture = preload("res://media/npcs/laughing_goskeiroanez.png")


@onready var kiss_dolore:Texture = preload("res://media/npcs/bdsm_demon.png")
@onready var kill_dolore:Texture = preload("res://media/npcs/dolore_kill.png")
@onready var marry_dolore:Texture = preload("res://media/npcs/pissed_off_dolore.png")

@onready var ref_az_image = $Control/VBoxContainer/HBoxContainer/azVBox/angel
@onready var ref_gos_image = $Control/VBoxContainer/HBoxContainer/gosVBox/scot
@onready var ref_dolore_image = $Control/VBoxContainer/HBoxContainer/doloreVBox/dolore


func _ready():
	ref_az_image.expand_mode=2

	ref_gos_image.expand_mode=2

	ref_dolore_image.expand_mode=2
	display_gos()
	display_dolore()
	display_az()
	set_stat_labels()

func getMaxStat(name:String):
	var npcStat
	if name == "azazael":
		npcStat = PlayerStatCounter.azazael
	elif name == "gos" :
		npcStat = PlayerStatCounter.gos
	else:
		npcStat = PlayerStatCounter.dolore
	var maxStat = "kiss"
	for stat in npcStat:
		if npcStat[maxStat]<npcStat[stat]:
			maxStat=stat
	return maxStat

func display_az():
	var stat = getMaxStat("azazael")
	var texture
	if stat =="kiss":
		texture =kiss_az
	elif stat == "kill":
		texture = kill_az
	else:
		texture = marry_az
	ref_az_image.texture = texture

func display_gos():
	var stat = getMaxStat("gos")
	var texture
	if stat =="kiss":
		texture =kiss_gos
	elif stat == "kill":
		texture = kill_gos
	else:
		texture = marry_gos
	ref_gos_image.texture = texture

		
func display_dolore():
	var stat = getMaxStat("dolore")
	var texture
	if stat =="kiss":
		texture =kiss_dolore
	elif stat == "kill":
		texture = kill_dolore
	else:
		texture = marry_dolore
	ref_dolore_image.texture = texture
	

func set_stat_labels():
	$Control/VBoxContainer/HBoxContainer/azVBox/kissHBox/stat.text = str(PlayerStatCounter.azazael["kiss"])
	$Control/VBoxContainer/HBoxContainer/azVBox/killHBox/stat.text = str(PlayerStatCounter.azazael["kill"])
	$Control/VBoxContainer/HBoxContainer/azVBox/marryHBox/stat.text = str(PlayerStatCounter.azazael["marry"])
	
	$Control/VBoxContainer/HBoxContainer/gosVBox/kissHBox/stat.text = str(PlayerStatCounter.gos["kiss"])
	$Control/VBoxContainer/HBoxContainer/gosVBox/killHBox3/stat.text = str(PlayerStatCounter.gos["kill"])
	$Control/VBoxContainer/HBoxContainer/gosVBox/marryHBox2/stat.text = str(PlayerStatCounter.gos["marry"])
	
	$Control/VBoxContainer/HBoxContainer/doloreVBox/kissHBox/stat.text = str(PlayerStatCounter.dolore["kiss"])
	$Control/VBoxContainer/HBoxContainer/doloreVBox/killHBox3/stat.text = str(PlayerStatCounter.dolore["kill"])
	$Control/VBoxContainer/HBoxContainer/doloreVBox/marryHBox2/stat.text = str(PlayerStatCounter.dolore["marry"])
	

