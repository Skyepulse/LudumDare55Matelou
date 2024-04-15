extends NPC

@export var has_waited = false
@export var has_red_slip = false

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


func transition():
	if dialogIndex == 0:
		dialogIndex = 1
	elif dialogIndex == 1:
		if has_waited:
			dialogIndex = 2
		else:
			dialogIndex = 1
	elif dialogIndex == 2:
		dialogIndex = 3
