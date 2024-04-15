extends TextureProgressBar

@onready var player = get_tree().get_root().get_node("mainScene").get_node("CharacterBody2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.kiss_changed.connect(update)
	update()


func update():
	value = player.KISS_STAT
