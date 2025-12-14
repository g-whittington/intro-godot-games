extends Node2D


@onready var icon: Sprite2D = $Icon

var pos: Vector2 = Vector2(200, 300)
var direction: Vector2 = Vector2.RIGHT
var speed := 20


func _ready() -> void:
	## Vectors

	# node position is stored as a vector
	print(icon.position)

	# we can update using another Vector
	icon.position = pos
	print(icon.position)


func _process(delta: float) -> void:
	icon.position += direction * 20 * delta
