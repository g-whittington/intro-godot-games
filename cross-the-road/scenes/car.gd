extends Area2D

# movement vars for the car instance
var direction : Vector2
var speed := 125

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	# sets direction based on spawn position
	if position.x < 0:
		direction = Vector2.RIGHT
		sprite_2d.flip_h = true
	else:
		direction = Vector2.LEFT

func _process(delta: float) -> void:
	# car should always move
	position += direction * speed * delta
	
	# should delete when off screen
	if position.x < -250 or position.x > 250:
		queue_free()
