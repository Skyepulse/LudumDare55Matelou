extends Control

const DIALOGNUM = 5
var chosenDialog = 0

func _ready():
	start_dialog()

func start_dialog():
	#choose a random dialog number between 1 and DIALOGNUM
	var randomDialog = randi() % DIALOGNUM + 1
	chosenDialog = randomDialog
	var corveeString = "corvee" + str(randomDialog)
	print(corveeString)
	Dialogic.start(corveeString)
	Dialogic.timeline_ended.connect(dialog_finished)
	Dialogic.signal_event.connect(dialog_signal)
	

func dialog_signal(param):
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
			addObject('Preserved Haggish')
		elif(param == 'choice2'):
			addStat('kiss', 'Dolore', +1)
			addStat('kiss', 'Gos', -1)
		elif(param == 'choice3'):
			addSouls(1)
			addStat('kiss', 'Gos', +1)
			addStat('marry', 'Azazael', -1)
	if(chosenDialog == 3):
		if(param == 'choice1'):
			addObject('Preserved Haggish')
		elif(param == 'choice2'):
			addStat('kiss', 'Dolore', +1)
			addStat('kiss', 'Gos', -1)
		elif(param == 'choice3'):
			addSouls(1)
			addStat('kiss', 'Gos', +1)
			addStat('marry', 'Azazael', -1)
	if(chosenDialog == 4):
		if(param == 'choice1'):
			addObject('Preserved Haggish')
		elif(param == 'choice2'):
			addStat('kiss', 'Dolore', +1)
			addStat('kiss', 'Gos', -1)
		elif(param == 'choice3'):
			addSouls(1)
			addStat('kiss', 'Gos', +1)
			addStat('marry', 'Azazael', -1)
	if(chosenDialog == 5):
		if(param == 'choice1'):
			addObject('Preserved Haggish')
		elif(param == 'choice2'):
			addStat('kiss', 'Dolore', +1)
			addStat('kiss', 'Gos', -1)
		elif(param == 'choice3'):
			addSouls(1)
			addStat('kiss', 'Gos', +1)
			addStat('marry', 'Azazael', -1)
	


func dialog_finished():
	Dialogic.timeline_ended.disconnect(dialog_finished)
	Dialogic.signal_event.disconnect(dialog_signal)

func addStat(statname, NPCname, value):
	pass

func addObject(objectName):
	pass

func addSouls(souls):
	pass
	
