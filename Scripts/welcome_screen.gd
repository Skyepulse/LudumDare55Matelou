extends Node2D


# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fade_in")


func _on_texture_button_pressed():
	$CanvasLayer/Control/anim_rectangle.visible = true
	$AnimationPlayer.play("fade_out")


func _on_animation_player_animation_finished(anim_name):
	if anim_name=="fade_in":
		$CanvasLayer/Control/anim_rectangle.visible = false
	else:
		get_tree().change_scene_to_file("res://Scenes/intro_scene_node.tscn")
