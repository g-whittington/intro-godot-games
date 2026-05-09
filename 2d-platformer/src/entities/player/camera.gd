extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("return_value_discarded")
	LevelManager.tilemap_bounds_change.connect(update_limits)
	
	update_limits(LevelManager.current_tilemap_bounds)


func update_limits(bounds: Dictionary[String, int]) -> void:
	if bounds.is_empty():
		return
	
	limit_left = bounds.get("left")
	limit_top = bounds.get("top")
	limit_right = bounds.get("right")
	limit_bottom = bounds.get("bottom")
