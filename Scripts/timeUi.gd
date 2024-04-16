extends Control

var player:CharacterBody2D = null
@onready var timeLabel = $Label
@onready var mainScene = get_tree().get_root().get_node("mainScene")
var time_left = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	time_left = mainScene.gameTimer.time_left
	time_left = (int(time_left))
	var minutes = time_left / 60
	var seconds = time_left % 60
	timeLabel.text = 'Time Left: ' + str(minutes) + ':' + str(seconds)
