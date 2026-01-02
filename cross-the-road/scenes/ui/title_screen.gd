extends Control


@onready var fastest_time: Label = $FastestTime


func _ready() -> void:
	fastest_time.text = "Fastest Time: " + str(Global.score_time)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enter_game"):
		@warning_ignore("return_value_discarded")
		get_tree().change_scene_to_file("res://scenes/game.tscn")
