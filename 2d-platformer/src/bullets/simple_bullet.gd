extends Area2D
class_name Bullet


const SPEED: int = 350

var direction: Vector2


# essentially just a consturctor kinda
func bullet_setup(pos: Vector2, dir: Vector2) -> void:
	# offset by dir * some # to make look like coming out of gun
	position = pos
	direction = dir


func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	rotation += SPEED * delta
