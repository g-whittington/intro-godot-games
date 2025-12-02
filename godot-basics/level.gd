extends Node2D

var i := 1
var j := 0

func _process(_delta: float) -> void:
	while j < 1000:
		i = i * i + 1 if i > 0 else 1
		print(i)
		j += 1
