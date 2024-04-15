extends TextureProgressBar


@onready var player = get_tree().get_root().get_node("mainScene").get_node("CharacterBody2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.marry_changed.connect(update)
	update()


func update():
	value = player.MARRY_STAT
