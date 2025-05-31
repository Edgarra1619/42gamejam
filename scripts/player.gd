class_name Player
extends CharacterBody2D

@export var movement_speed: int = 800
@export var dash_speed: int = 8000
@export var potion: PackedScene
var in_dash: bool = false
var dash_destination: Vector2
static var player : Player

func _ready() -> void:
	player = self
	pass

func throw() -> void:
	var pos : Vector2 = get_global_mouse_position()
	var new_potion : Potion = RedPotion.new_potion(pos)
	get_tree().current_scene.add_child(new_potion)
	new_potion.global_position = global_position


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("throw_potion")):
		throw()

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

func _on_area_2d_body_entered(body: Node2D) -> void:
	set_deferred("process_mode", PROCESS_MODE_DISABLED)
