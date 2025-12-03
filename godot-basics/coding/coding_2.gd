extends Node2D

@export var move_speed := Vector2(200.0, 200.0)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var icon: Sprite2D = $Icon

var sprite_size := Vector2.ZERO

# called once upon Node loading into a scene
func _ready() -> void:
	# can edit properties in script
	sprite_2d.rotation = -PI/4
	
	# can also call object methods from script
	sprite_2d.rotate(PI/4)
	
	sprite_size = sprite_2d.texture.get_size() / 2
	
	
# called every frame
func _process(delta: float) -> void:
	sprite_2d.rotate(-PI/4 * delta)
	
	var viewport := get_viewport_rect().size
	
	# update icon position
	sprite_2d.position += move_speed * delta
	# make the icon bounce off the edges of the screen
	if sprite_2d.position.x < sprite_size.x or sprite_2d.position.x > viewport.x - sprite_size.x:
		# clamping makes sure it stays in the viewport window
		sprite_2d.position.x = clampf(sprite_2d.position.x, sprite_size.x, viewport.x - sprite_size.x)
		move_speed.x = -move_speed.x
	if sprite_2d.position.y < sprite_size.y or sprite_2d.position.y > viewport.y - sprite_size.y:
		# clamping just make sure there is no clipping and it getting stuck in the wall
		sprite_2d.position.y = clampf(sprite_2d.position.y, sprite_size.y, viewport.y - sprite_size.y)
		move_speed.y = -move_speed.y
		
	# Exercise: Create a moving Sprite2D that moves from the top left to the bottom
	#           right while also scaling up
	
	icon.position += Vector2(200, 85) * delta
	icon.scale += Vector2(0.5, 0.5) * delta
