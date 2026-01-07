extends CharacterBody2D


# movement values
const SPEED: int = 300
const JUMP_VELOCITY: int = -400
const GRAVITY: int = 980

# small state machine
enum State {FLOOR, JUMP, FALL}

var active_state: State = State.FLOOR


func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("move_left","move_right")
	
	match active_state:
		State.FLOOR:
			# handles both idle and moving
			velocity.x = direction * SPEED
			# handle animation here
			# flip sprite horizontally
			
			# conditions to not be on the floor
			if Input.is_action_just_pressed("jump"):
				change_state(State.JUMP)
			if not is_on_floor():
				change_state(State.FALL)
		State.JUMP:
			velocity.x = direction * SPEED
			# flip sprite horizontally
			# also calculate here so we hit max jump
			velocity.y += GRAVITY * delta
			
			if Input.is_action_just_released("jump") or velocity.y >= 0:
				velocity.y = 0
				change_state(State.FALL)
		State.FALL:
			velocity.x = direction * SPEED
			# flip sprite horizontally
			velocity.y += GRAVITY * delta
			
			# fall untill on a floor
			if is_on_floor():
				change_state(State.FLOOR)
			
	@warning_ignore("return_value_discarded")
	move_and_slide()
	

func change_state(to_state: State) -> void:
	active_state = to_state
	
	# things to happen once on state transition
	match active_state:
		State.FLOOR:
			pass
		State.JUMP:
			velocity.y = JUMP_VELOCITY
			# play animation
		State.FALL:
			pass
			# play animation
