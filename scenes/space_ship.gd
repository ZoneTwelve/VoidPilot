extends CharacterBody2D

const THRUST = 400.0
const ROTATION_SPEED = PI
const MAX_SPEED = 600.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var current_frame := 0
var frame_timer := 0.0
const FRAME_SPEED := 10.0  # Higher = faster transition

func _physics_process(delta: float) -> void:
	# --- ROTATION ---
	if Input.is_action_pressed("ui_left"):
		rotation -= ROTATION_SPEED * delta
	if Input.is_action_pressed("ui_right"):
		rotation += ROTATION_SPEED * delta

	var forward = Vector2.RIGHT.rotated(rotation - PI / 2)

	# --- THRUST ---
	if Input.is_action_pressed("ui_up"):
		velocity += forward * THRUST * delta
		update_thrust_animation(true, delta)
	else:
		update_thrust_animation(false, delta)

	if Input.is_action_pressed("ui_down"):
		velocity -= forward * THRUST * delta

	# --- LIMIT SPEED ---
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

	# --- MOVE ---
	move_and_slide()

# --- Animate sprite based on thrust ---
func update_thrust_animation(thrusting: bool, delta: float) -> void:
	if thrusting:
		# Gradually increase frame up to 2
		frame_timer += FRAME_SPEED * delta
	else:
		# Gradually decrease frame back to 0
		frame_timer -= FRAME_SPEED * delta

	# Clamp between 0 and 2
	frame_timer = clamp(frame_timer, 0, 2)
	current_frame = int(round(frame_timer))
	sprite.frame = current_frame
