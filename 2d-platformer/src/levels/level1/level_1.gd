extends Node2D


const BULLET: PackedScene = preload("uid://di1lx4fcsq3jl")

@onready var bullets: Node2D = %Bullets
@onready var background_layer: TileMapLayer = %BackgroundLayer


func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tilemap_bounds(background_layer))


func get_tilemap_bounds(tilemap_layer: TileMapLayer) -> Dictionary[String, int]:
	# pull out the bounding box for tile map
	var used_rect: Rect2i = tilemap_layer.get_used_rect()
	var quant_size: int = tilemap_layer.rendering_quadrant_size
	
	# get each extreme
	var bounds: Dictionary[String, int] = {
		"left":   used_rect.position.x * quant_size,
		"top":    used_rect.position.y * quant_size,
		"right":  used_rect.end.x * quant_size,
		"bottom": used_rect.end.y * quant_size,
	}
	
	return bounds


func _on_player_shot_fired(pos: Vector2, dir: Vector2) -> void:
	var bullet: Bullet = BULLET.instantiate()
	bullet.bullet_setup(pos, dir)
	bullets.add_child(bullet)
