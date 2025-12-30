class_name Player
extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var speed: int = 100

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:	
	# assign Input Mapping to each direction, also normalizes itself
	direction = Input.get_vector("left", "right", "up", "down")
	
	# assign to velocity of physics body
	velocity = direction * speed
	
	# play correct animation based on direction
	animation()
	
	# allow Godot to calculate position
	move_and_slide()


func animation():
	# only false with Vector2(0,0)
	if direction:
		animated_sprite_2d.flip_h = direction.x > 0
		if direction.y > 0:
			animated_sprite_2d.play("walk_down")
		elif direction.y < 0:
			animated_sprite_2d.play("walk_up")
		else:
			animated_sprite_2d.play("walk_left")
	# each animation frame 0 is idle
	else:
		animated_sprite_2d.frame = 0
