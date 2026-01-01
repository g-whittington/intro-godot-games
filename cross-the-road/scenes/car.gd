extends Area2D

# movement vars for the car instance
var direction : Vector2 = Vector2.LEFT
var speed: int = 125

# make the sprite be random
var car_sprite_colors: Array[Resource] = [
	preload("res://graphics/cars/yellow.png"),
	preload("res://graphics/cars/red.png"),
	preload("res://graphics/cars/green.png")
]

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	# sets direction based on spawn position
	if position.x < 0:
		direction = Vector2.RIGHT
		sprite_2d.flip_h = true

	# select the sprite
	sprite_2d.texture = car_sprite_colors.pick_random()

func _process(delta: float) -> void:
	# car should always move
	position += direction * speed * delta
	
	# should delete when off screen
	if position.x < -250 or position.x > 250:
		queue_free()
