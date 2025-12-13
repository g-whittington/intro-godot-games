extends Node2D

@export var velocity := Vector2(200, 200)

@onready var icon: Sprite2D = $Icon

func _process(delta: float) -> void:
	icon.position.x += velocity.x * delta
	
	var viewport := get_viewport_rect()
	
	if icon.position.x >= viewport.size.x or icon.position.x <= 0:
		velocity.x = -velocity.x
	
