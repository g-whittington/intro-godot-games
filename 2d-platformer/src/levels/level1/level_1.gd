extends Node2D


const BULLET: PackedScene = preload("uid://di1lx4fcsq3jl")

@onready var bullets: Node2D = $Bullets


func _on_player_shot_fired(pos: Vector2, dir: Vector2) -> void:
	var bullet: Bullet = BULLET.instantiate()
	bullet.bullet_setup(pos, dir)
	bullets.add_child(bullet)
	
