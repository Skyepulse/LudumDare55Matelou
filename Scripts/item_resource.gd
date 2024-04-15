extends Resource
class_name Item

enum Liking {LOVE, NEUTRAL, HATE}

@export var name: String
@export var icon: Texture2D
@export var azazael_liking: Liking
@export var dolore_liking: Liking
@export var gos_liking: Liking
