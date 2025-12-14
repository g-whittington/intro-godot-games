extends Node2D


@onready var icon: Sprite2D = $Icon

var pos: Vector2 = Vector2(200, 300)

# values to control the icon to move
var direction: Vector2 = Vector2.RIGHT + Vector2.UP
var speed: float = 200
var viewport: Vector2
var icon_size: Vector2

var my_array: Array = [1, 2, 3, 'a', 'b', 'c', true, [4, 5, 6]]

var my_dict: Dictionary = {
	"test":123,
	[1, 2, 3]:{1:2, 2:3, 4:5},
	456:"weird"
}

# Lua style, keys are treated as strings, not references to variables
var my_lua_dict: Dictionary[String, String] = {
	Tom = "sad",
	Ted = "happy",
	Jen = "hungry",
	Juniper = "tired"
}


func _ready() -> void:
	## Vectors
	# node position is stored as a vector
	print(icon.position)

	# we can update using another Vector
	icon.position = pos
	print(icon.position)
	
	print("\n\n\n")
	
	## Arrays
	# can iterate though them with for loop
	for item in my_array:
		print(item, item)
	
	print("\n")	
	
	# indexing starting at zero
	print("The first item in the array: ", my_array[0])
	print("The last item in the array: ", my_array[-1])
	
	print("\n\n\n")
	
	## Dictonaries
	# can iterate though them with for loop, default kets
	for key in my_dict:
		print("Key: ", key)
		print("Value: ", my_dict[key])
		
	print("\n")
		
	for value in my_lua_dict.values():
		print(value)
		
	# get the sizes of the rects
	viewport = get_viewport_rect().size
	icon_size = icon.get_rect().size * icon.scale / 2.0
	


func _process(delta: float) -> void:
	# mvoe the icon
	icon.position += direction * speed * delta
	
	# check if icon collides with wall
	if icon.position.x > viewport.x - icon_size.x || icon.position.x < icon_size.x:
		# update direction to move away from wall
		direction.x = -direction.x
		icon.position.x = clampf(icon.position.x, icon_size.x, viewport.x)
		
	if icon.position.y > viewport.y - icon_size.y || icon.position.y < icon_size.y:
		direction.y = -direction.y
		icon.position.y = clampf(icon.position.y, icon_size.y, viewport.y)
