extends CharacterBody2D


var direction: Vector2 = Vector2.ZERO
var speed: int = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exercise"):
		print("Only Once")


func _physics_process(_delta: float) -> void:	
	# assign Input Mapping to each direction, also normalizes itself
	direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * speed
	move_and_slide()
