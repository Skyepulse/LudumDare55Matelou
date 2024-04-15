extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.timeline_ended.connect(ended)
	Dialogic.start("intro_timeline")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func ended():
	Dialogic.timeline_ended.disconnect(ended)
	print("intro done")
	get_tree().change_scene_to_file("res://Scenes/mainScene.tscn")
