extends Node2D

var i := 1

func _process(_delta: float) -> void:
	while true:
		i = i * i + 1 if i > 0 else 1
		print(i)
