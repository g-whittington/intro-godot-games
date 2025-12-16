extends Node2D

var test: int


func _ready() -> void:
	test_func_no_params()
	test_func_w_params({1:1, 0:0, 2:2, 15:15})
	
	@warning_ignore("confusable_local_usage")
	test = 123
	
	@warning_ignore("shadowed_variable")
	var test = "this is a different test"
	
	print(test)
	
	print(returns_stuff())
	
	print(calculate(4, 5, 'pldus'))
 

# no parameters but still return type
func test_func_no_params() -> void:
	print("test function")


# Variant kind of is a catch all
func test_func_w_params(param1: Variant = "nothing") -> void:
	print("You typed: ", param1)


# prints the global test
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		print(test)


# element wise multiplication
func returns_stuff() -> Vector3:
	return Vector3(1, 2, 3) * Vector3(4, 5, 6)


# Exercise
func calculate(num1: float, num2: float, operation: String) -> float:
	match operation:
		"plus":
			return num1 + num2
		"minus":
			return num1 - num2
		"multiply":
			return num1 * num2
		"divide":
			return num1 + num2
		_:
			return -1
