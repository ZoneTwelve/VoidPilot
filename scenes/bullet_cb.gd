extends CharacterBody2D

var _position: Vector2
var _rotation: float
var speed = 20000.0  # Removed unused _direction variable

func _ready():
	pass
	#global_position = _position
	#global_rotation = _rotation
	# Connect via editor instead if preferred
	#$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)

func _physics_process(delta: float) -> void:
	var forward = Vector2.UP.rotated(global_rotation)
	position += forward * speed * delta  # Added delta for frame independence
	move_and_slide()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	
	print("Bye")
	queue_free()  # Direct cleanup without debug print
	pass # Replace with function body.
