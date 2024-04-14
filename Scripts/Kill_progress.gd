extends TextureProgressBar


@onready var player = $'../../../../CharacterBody2D'

# Called when the node enters the scene tree for the first time.
func _ready():
	player.kill_changed.connect(update)
	update()


func update():
	value = player.KILL_STAT

