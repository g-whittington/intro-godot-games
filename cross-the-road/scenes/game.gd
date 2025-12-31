extends Node2D

# preloaded using the uid
const CAR: PackedScene = preload("uid://cik0suxpxidrw")

# Container to hold all spawned cars
@onready var active_cars: Node2D = $CarSystem/ActiveCars
@onready var car_start_positions: Node2D = $CarSystem/CarStartPositions


func _on_win_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		print("You Win!") 


func _on_car_spawn_timer_timeout() -> void:
	# create new car object
	var car: Area2D = CAR.instantiate()
	
	# randomly choose the car start position
	var start_pos: Marker2D = car_start_positions.get_children().pick_random()
	car.position = start_pos.position
	
	# connect the body_entered signal in code
	car.body_entered.connect(go_to_title)
	
	active_cars.add_child(car)
	
func go_to_title(_body: Node2D) -> void:
	print("collide ", str(_body))
