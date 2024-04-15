extends Node2D
var anim_begin=0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fade_in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func ended():
	Dialogic.timeline_ended.disconnect(ended)
	print("intro done")
	$AnimationPlayer.play("fade_out")


func _on_animation_player_animation_finished(anim_name):
	if anim_begin==0:
		Dialogic.timeline_ended.connect(ended)
		Dialogic.start("intro_timeline")
		anim_begin+=1
	else:
		get_tree().change_scene_to_file("res://Scenes/mainScene.tscn")
