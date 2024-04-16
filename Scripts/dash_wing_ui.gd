extends Control

const SPRITE_SCALE = 4
const INVENTORY_SPRITE_SCALE = 1
var panelContainer:HBoxContainer
var panelContainer2:HBoxContainer
var panels
@onready var inventoryPanels = $Inventory/HBoxContainer.get_children()
@onready var inventoryPanel = $Inventory/HBoxContainer/Panel
@onready var beatingHeartItemType:Resource = preload("res://items/heart.tres")
@onready var holyWater:Resource = preload("res://items/water.tres")
@onready var blueTeddyBear:Resource = preload("res://items/tedyy.tres")
@onready var pigeonBloodRuby:Resource = preload("res://items/bloodRuby.tres")
@onready var preservedHaggish:Resource = preload("res://items/haggish.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	panelContainer = $wings/VBoxContainer/HBoxContainer
	panels = panelContainer.get_children()
	for panel in panels:
		var sprite = panel.get_node("Sprite2D")
		sprite.set_scale(Vector2(SPRITE_SCALE, SPRITE_SCALE))
		var spriteSize = sprite.get_texture().get_size()*SPRITE_SCALE
		panel.set_custom_minimum_size(Vector2(spriteSize.x, spriteSize.y))
		sprite.set_position(Vector2(spriteSize.x/2, spriteSize.y/2))
	panelContainer2 = $wings/VBoxContainer/HBoxContainer2
	var panel = panelContainer2.get_node("Panel")
	var spr = panel.get_node("Sprite2D")
	spr.set_scale(Vector2(SPRITE_SCALE/2, SPRITE_SCALE/2))
	var spriteS = spr.get_texture().get_size()*SPRITE_SCALE/2
	panel.set_custom_minimum_size(Vector2(spriteS.x, spriteS.y))
	spr.set_position(Vector2(spriteS.x/2, spriteS.y/2))

	inventoryPanel.hide()
	inventoryPanel.mouse_entered.connect(_on_panel_mouse_entered)
	inventoryPanel.mouse_exited.connect(_on_panel_mouse_exited)
	for pan in inventoryPanels:
		var sp = pan.get_node('Sprite2D')
		pan.set_custom_minimum_size(Vector2(sp.texture.get_size().x * INVENTORY_SPRITE_SCALE, sp.texture.get_size().y * INVENTORY_SPRITE_SCALE))
		sp.texture = null
		pan.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_dash(dashNum:int):
	for i in range(panels.size()):
		var panel = panels[i]
		var sprite = panel.get_node("Sprite2D")
		if i < dashNum:
			sprite.modulate.a = 1.0
		else:
			sprite.modulate.a = 0.2

func update_souls(souls:int):
	var label = $wings/VBoxContainer/HBoxContainer2/Label
	label.text = str(souls)


func update_inventory(inventory:Dictionary):
	if(inventory.size() == 0):
		inventoryPanel.hide()
		return
	var keys = inventory.keys()
	var randomKey = keys[randi() % keys.size()]
	var sprite = inventoryPanel.get_node('Sprite2D')
	if(randomKey == beatingHeartItemType.name):
		sprite.texture = beatingHeartItemType.icon
	elif(randomKey == holyWater.name):
		sprite.texture = holyWater.icon
	elif(randomKey == blueTeddyBear.name):
		sprite.texture = blueTeddyBear.icon
	elif(randomKey == pigeonBloodRuby.name):
		sprite.texture = pigeonBloodRuby.icon
	elif(randomKey == preservedHaggish.name):
		sprite.texture = preservedHaggish.icon
	
	inventoryPanel.get_node("Label").text = str(inventory[randomKey])
	
	sprite.set_scale(Vector2(INVENTORY_SPRITE_SCALE, INVENTORY_SPRITE_SCALE))
	var inventoryPosition = inventoryPanel.position
	var inventoryMiddle = inventoryPosition + Vector2(inventoryPanel.size.x/2, inventoryPanel.size.y/2)
	sprite.position = inventoryMiddle
	inventoryPanel.show()
	
	keys.remove_at(keys.find(randomKey))
	var otherPanels = []
	for pan in inventoryPanels:
		if(pan.name == "Panel"):
			continue
		var sp = pan.get_node('Sprite2D')
		sp.texture = null
		var label = pan.get_node('Label')
		label.text = "0"
		otherPanels.append(pan)

	var keynum = 0
	for key in keys:
		var pan = otherPanels[keynum]
		var sp = pan.get_node('Sprite2D')
		var label = pan.get_node('Label')
		if(key == beatingHeartItemType.name):
			sp.texture = beatingHeartItemType.icon
		elif(key == holyWater.name):
			sp.texture = holyWater.icon
		elif(key == blueTeddyBear.name):
			sp.texture = blueTeddyBear.icon
		elif(key == pigeonBloodRuby.name):
			sp.texture = pigeonBloodRuby.icon
		elif(key == preservedHaggish.name):
			sp.texture = preservedHaggish.icon
		label.text = str(inventory[key])
		sp.set_scale(Vector2(INVENTORY_SPRITE_SCALE, INVENTORY_SPRITE_SCALE))
		var pos = pan.position
		var panName = pan.name
		var middle = pos + Vector2(-pan.size.x/2 - (pan.size.x)*(max(0, keynum)) - 8, pan.size.y/2)
		sp.position = middle
		print(pan.name, key, inventory[key])
		keynum += 1

func _on_panel_mouse_entered():
	for pan in inventoryPanels:
		if(pan.name == "Panel"):
			continue
		pan.show()

func _on_panel_mouse_exited():
	for pan in inventoryPanels:
		if(pan.name == "Panel"):
			continue
		pan.hide()
