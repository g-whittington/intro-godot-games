extends Sprite2D


var direction: Vector2 = Vector2.RIGHT
var speed: int = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	# grabs the position of the node attached to it
	position += direction * speed * delta
