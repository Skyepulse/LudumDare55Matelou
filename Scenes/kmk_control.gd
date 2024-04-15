extends Control

var player: CharacterBody2D = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_kiss_pressed():
	if player and player.current_npc:
		player.current_npc.on_kiss()

func _on_marry_pressed():
	if player and player.current_npc:
		player.current_npc.on_marry()

func _on_kill_pressed():
	if player and player.current_npc:
		player.current_npc.on_kill()
