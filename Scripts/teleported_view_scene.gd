extends Control

const DIALOGNUM = 5
var chosenDialog = 0
var player:CharacterBody2D = null

@onready var beatingHeartItemType:Resource = preload("res://items/heart.tres")
@onready var holyWater:Resource = preload("res://items/water.tres")
@onready var blueTeddyBear:Resource = preload("res://items/tedyy.tres")
@onready var pigeonBloodRuby:Resource = preload("res://items/bloodRuby.tres")
@onready var preservedHaggish:Resource = preload("res://items/haggish.tres")


func _ready():
	pass
func start_dialog():
	#choose a random dialog number between 1 and DIALOGNUM
	var randomDialog = randi() % DIALOGNUM
	print(randomDialog)
	chosenDialog = randomDialog
	var corveeString = "corvee" + str(randomDialog)
	print(corveeString)
	Dialogic.start(corveeString)
	Dialogic.timeline_ended.connect(dialog_finished)
	Dialogic.signal_event.connect(dialog_signal)
	

func dialog_signal(param):
	if(chosenDialog == 0):
		if(param == 'choice1'):
			addStat('marry', 'Azazael', -1)
			addSouls(2)
		elif(param == 'choice2'):
			addStat('marry', 'Azazael', -1)
			addStat('kiss', 'Dolore', +1)
			addObject('Still beating human heart')
		elif(param == 'choice3'):
			addStat('marry', 'Azazael', +1)
	if(chosenDialog == 1):
		if(param == 'choice1'):
			addObject('Preserved Haggish')
		elif(param == 'choice2'):
			addStat('kiss', 'Dolore', +1)
			addStat('kiss', 'Gos', -1)
		elif(param == 'choice3'):
			addSouls(1)
			addStat('kiss', 'Gos', +1)
			addStat('marry', 'Azazael', -1)
	if(chosenDialog == 2):
		if(param == 'choice1'):
			addObject('holy water')
		elif(param == 'choice2'):
			addSouls(5)
			addStat('marry', 'Azazael', -1)
			addStat('kiss', 'Gos', +1)
		elif(param == 'choice3'):
			addSouls(1)
	if(chosenDialog == 3):
		print(param)
		if(param == 'choice1'):
			addSouls(1)
			addObject('ruby')
		elif(param == 'choice2'):
			addStat('marry', 'Azazael', +1)
			addStat('kiss', 'Dolore', +1)
		elif(param == 'choice3'):
			addObject('ruby')
			print('choice3 ruby')
	if(chosenDialog == 4):
		if(param == 'choice1'):
			addObject('Blue teddy bear')
			addStat('marry', 'Azazael', +1)
		elif(param == 'choice2'):
			addSouls(2)
			addObject('Blue teddy bear')
		elif(param == 'choice3'):
			addSouls(2)	


func dialog_finished():
	Dialogic.timeline_ended.disconnect(dialog_finished)
	Dialogic.signal_event.disconnect(dialog_signal)
	player.onCorveeFinished()

func addStat(statname, NPCname, value):
	var npc = get_tree().get_root().get_node("mainScene").get_node(NPCname)
	npc.add_to_stat(statname, value * 10)

func addObject(objectName):
	if(objectName == 'Still beating human heart'):
		var objname = beatingHeartItemType.name
		player.add_to_inventory(objname)
	if(objectName == 'holy water'):
		var objname = holyWater.name
		player.add_to_inventory(objname)
	if(objectName == 'Blue teddy bear'):
		var objname = blueTeddyBear.name
		player.add_to_inventory(objname)
	if(objectName == 'ruby'):
		var objname = pigeonBloodRuby.name
		player.add_to_inventory(objname)
	if(objectName == 'Preserved Haggish'):
		var objname = preservedHaggish.name
		player.add_to_inventory(objname)


func addSouls(souls):
	player.addSouls(souls)
	
