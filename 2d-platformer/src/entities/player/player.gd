extends CharacterBody2D


# signal and scene to handle shooting
signal shot_fired(pos: Vector2, dir: Vector2)

# movement values
const SPEED: int = 300
const JUMP_VELOCITY: int = -400
const GRAVITY: int = 980

var direction: float

# small state machine
enum State {FLOOR, JUMP, FALL}
var active_state: State = State.FLOOR

# so a cool down can be inplemented
var can_shoot: bool = true
@onready var reload_timer: Timer = %ReloadTimer

# to handle sprites with multiple parts doing different things
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left","move_right")
	velocity.x = direction * SPEED
	# always apply gravity
	velocity.y += GRAVITY * delta
	
	# only flip sprite when moving
	sprite_2d.flip_h = direction < 0 if direction else sprite_2d.flip_h
	
	match active_state:
		State.FLOOR:
			# conditions to not be on the floor
			if Input.is_action_just_pressed("jump"):
				change_state(State.JUMP)
			if not is_on_floor():
				change_state(State.FALL)
		State.JUMP:
			if Input.is_action_just_released("jump") or velocity.y >= 0:
				velocity.y = 0
				change_state(State.FALL)
		State.FALL:
			# fall until on a floor
			if is_on_floor():
				change_state(State.FLOOR)
	
	# firing of weapon can be from any state
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shot_fired.emit(
			position,
			get_local_mouse_position().normalized()
		)
		can_shoot = false
		reload_timer.start()
	
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


func _on_reload_timer_timeout() -> void:
	print("reloading...")
	can_shoot = true
