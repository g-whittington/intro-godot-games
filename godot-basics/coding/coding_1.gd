extends Node2D

func _ready() -> void:
	something()
	
func _process(_delta: float) -> void:
	pass
	
func something() -> void:
	print("something")
	print(123)
