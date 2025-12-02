extends Node2D

@export var move_speed := Vector2(200.0, 200.0)

@onready var sprite_2d: Sprite2D = $Sprite2D

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
	
	sprite_2d.position += move_speed * delta
	if sprite_2d.position.x < sprite_size.x or sprite_2d.position.x > viewport.x - sprite_size.x:
		move_speed.x = -move_speed.x
	if sprite_2d.position.y < sprite_size.y or sprite_2d.position.y > viewport.y - sprite_size.y:
		move_speed.y = -move_speed.y
