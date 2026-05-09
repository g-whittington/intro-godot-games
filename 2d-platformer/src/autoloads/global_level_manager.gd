extends Node


signal tilemap_bounds_change(bounds: Dictionary[String, int])

var current_tilemap_bounds: Dictionary[String, int]


func change_tilemap_bounds(bounds: Dictionary[String, int]) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_change.emit(bounds)
