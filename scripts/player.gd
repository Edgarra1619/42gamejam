extends CharacterBody2D

@export var movement_speed: int = 300
@export var dash_speed: int = 1800
@export var potion: PackedScene
var in_dash: bool = false
var dash_destination: Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("throw_potion")):
		var new_potion = potion.instantiate()
		new_potion.position = get_global_mouse_position()
		get_tree().current_scene.add_child(new_potion)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	if (Input.is_action_just_pressed("dash") and $DashCooldownTimer.is_stopped()):
		in_dash = true
		dash_destination = get_global_mouse_position()
		$DashTimer.start()
		$DashCooldownTimer.start()
	if (in_dash):
		direction = global_position.move_toward(dash_destination, dash_speed * delta) - global_position
		velocity = direction / delta
		if direction.is_zero_approx():
			in_dash = false
	else:
		direction.x = Input.get_axis("move_left", "move_right")
		direction.y = Input.get_axis("move_up", "move_down")
		direction = direction.normalized()
		velocity = direction * movement_speed
	move_and_slide()

func _on_dash_timer_timeout() -> void:
	in_dash = false
