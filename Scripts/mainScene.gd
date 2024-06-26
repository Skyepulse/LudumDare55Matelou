extends Node2D

var gameTimer : Timer
var GAME_DURATION = 600 #ten minute playthrough

# Called when the node enters the scene tree for the first time.
func _ready():
	gameTimer = Timer.new()
	gameTimer.set_one_shot(true)
	gameTimer.timeout.connect(end_game)
	add_child(gameTimer)
	
	gameTimer.start(GAME_DURATION)

func pause():
	gameTimer.set_paused ( true )

func resume():
	gameTimer.set_paused ( false )

func getTimeLeft():
	return gameTimer.time_left

func end_game():
	print("game ended")
	if Dialogic.current_timeline:
		print("inside text")
		Dialogic.timeline_ended.connect(switch_scene)
	else:
		switch_scene()

func switch_scene():
	get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")
