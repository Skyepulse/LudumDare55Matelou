extends Node2D
var dialog = "Hello! This is a test dialog from"

var sceneCanvasLayer:CanvasLayer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	sceneCanvasLayer = get_tree().get_root().get_child(0).get_node("SceneCanvasLayer") as CanvasLayer
	if sceneCanvasLayer == null: print("CanvasLayer not found!!")
	dialog += " " + str(name)

func talk():
	sceneCanvasLayer.get_node("NPC_TALK_VIEW").talk_dialog(dialog, name)

