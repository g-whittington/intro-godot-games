extends Area2D
class_name Bullet


const SPEED: int = 350

var direction: Vector2

@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready() -> void:
	sprite_2d.scale = Vector2.ZERO
	
	var tween: Tween = get_tree().create_tween()
	@warning_ignore("return_value_discarded")
	tween.tween_property(sprite_2d, "scale", Vector2.ONE, 0.2)


# essentially just a consturctor kinda
func bullet_setup(pos: Vector2, dir: Vector2) -> void:
	position = pos
	direction = dir


func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	rotation += SPEED * delta
