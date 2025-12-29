extends Node2D


var direction: Vector2 = Vector2.ZERO
var speed: int = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exercise"):
		print("Only Once")


func _physics_process(delta: float) -> void:
	# set back to (0, 0) each frame
	#direction = Vector2.ZERO
	# basic movement vector based on checking each input manually
	#if Input.is_action_pressed("up"):
		#direction.y -= 1
	#if Input.is_action_pressed("down"):
		#direction.y += 1
	#if Input.is_action_pressed("left"):
		#direction.x -= 1
	#if Input.is_action_pressed("right"):
		#direction.x += 1
	
	# normalize vector so diagnonal movement is not fasterxz
	#position += direction.normalized() * speed * delta
	
	# assign Input Mapping to each direction, also normalizes itself
	direction = Input.get_vector("left", "right", "up", "down")
	
	position += direction * speed * delta
