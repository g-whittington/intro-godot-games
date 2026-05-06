extends CharacterBody2D


# signal and scene to handle shooting
signal shot_fired(pos: Vector2, dir: Vector2)

# movement values
const SPEED: int = 300
const JUMP_VELOCITY: int = -400
const GRAVITY: int = 980

var direction: float
	# fall until on a floor
# small state machine
enum State {FLOOR, JUMP, FALL}
var active_state: State = State.FLOOR

# so a cool down can be inplemented
var can_shoot: bool = true
@onready var reload_timer: Timer = %ReloadTimer

# to handle sprites with multiple parts doing different things
@onready var legs: Sprite2D = %Legs
@onready var torso: Sprite2D = %Torso
@onready var animation_player: AnimationPlayer = %AnimationPlayer

# mapping mouse direction to sprite frames
const gun_directions : Dictionary[Vector2i, int] = {
	Vector2i(1,0):   0,
	Vector2i(1,1):   1,
	Vector2i(0,1):   2,
	Vector2i(-1,1):  3,
	Vector2i(-1,0):  4,
	Vector2i(-1,-1): 5,
	Vector2i(0,-1):  6,
	Vector2i(1,-1):  7
}


func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left","move_right")
	velocity.x = direction * SPEED
	# always apply gravity
	velocity.y += GRAVITY * delta
	
	# only flip sprite when moving
	legs.flip_h = direction < 0 if direction else legs.flip_h
	
	match active_state:
		State.FLOOR:
			# conditions to not be on the floor
			if Input.is_action_just_pressed("jump"):
				change_state(State.JUMP)
			if not is_on_floor():
				change_state(State.FALL)
		State.JUMP:
			if Input.is_action_just_released("jump") or velocity.y >= 0:
				# /3 to make feel more natural 
				velocity.y = velocity.y/3
				change_state(State.FALL)
		State.FALL:
			# fall until on a floor
			if is_on_floor():
				change_state(State.FLOOR)
	
	# play animation based on state
	animation(active_state)
	
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


func animation(current_state: State) -> void:
	# leg animation
	match current_state:
		State.FLOOR:
			if direction:
				animation_player.current_animation = "legs_run"
			else:
				animation_player.current_animation = "legs_idle"
		State.JUMP, State.FALL:
			animation_player.current_animation = "legs_air"
	
	# torso animation
	var current_mouse_pos: Vector2 = get_local_mouse_position().normalized()
	var gun_frame : Vector2i = Vector2i(
		roundi(current_mouse_pos.x),
		roundi(current_mouse_pos.y)
	)
	torso.frame = gun_directions[gun_frame]


func _on_reload_timer_timeout() -> void:
	print("reloading...")
	can_shoot = true
