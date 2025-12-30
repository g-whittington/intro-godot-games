extends Node2D


func _on_win_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		print("You Win!")
