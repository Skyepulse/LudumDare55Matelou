extends NPC

@export var has_waited = false
@export var has_red_slip = false

func _ready():
	dialogs = [
		"DoloreMeet"
	]
	kiss = 20
	marry = 30
	kill = 50


func transition():
	if dialogIndex < 0:
		dialogIndex = 0
