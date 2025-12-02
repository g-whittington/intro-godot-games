extends Node2D

func _ready() -> void:
	# can edit properties in script
	$Sprite2D.rotation = -PI/4
	
	# can also call object methods from script
	$Sprite2D.rotate(-PI/4)
