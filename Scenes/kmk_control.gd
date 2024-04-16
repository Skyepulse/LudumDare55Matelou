extends Control

var player: CharacterBody2D = null

func _on_kiss_pressed():
	if player and player.current_npc:
		player.current_npc.on_kiss()

func _on_marry_pressed():
	if player and player.current_npc:
		player.current_npc.on_marry()

func _on_kill_pressed():
	if player and player.current_npc:
		player.current_npc.on_kill()
