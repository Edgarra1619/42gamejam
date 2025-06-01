class_name Player
extends CharacterBody2D

signal switched_potion
signal updated_potion

static var player: Player

@export var movement_speed: int = 300
@export var dash_speed: int = 3000
var in_dash: bool = false
var dash_destination: Vector2

const potion_limits: Array[int] = [3, 1, 1, 1]
static var potions: Array = [RedPotion, PurplePotion, GreenPotion, GoldPotion]
var potion_timers: Array[Timer]
var brewed_potions: Array = potion_limits.duplicate(true)
var current_potion: int = 0

func _ready() -> void:
	player = self
	potion_timers = [$RedPotionTimer, $PurplePotionTimer, $GreenPotionTimer, $GoldPotionTimer]
	$Sprite.play("idle")
	$Sprite.flip_h = true

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("throw_potion")):
		throw()
	if (Input.is_action_just_pressed("switch_potion")):
		switch_potion()
	if (not $ActionTimer.is_stopped() or in_dash):
		return
	var hor_axis = Input.get_axis("move_left", "move_right")
	if (hor_axis > 0):
		$Sprite.flip_h = true
	elif (hor_axis < 0):
		$Sprite.flip_h = false
	if (Input.get_axis("move_left", "move_right") != 0 or Input.get_axis("move_up", "move_down") != 0):
		$Sprite.animation = "walk"
	else:
		$Sprite.animation = "idle"

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	if (Input.is_action_just_pressed("dash") and $DashCooldownTimer.is_stopped()):
		in_dash = true
		set_collision_layer_value(5, true)
		dash_destination = get_global_mouse_position()
		$DashTimer.start()
		$DashCooldownTimer.start()
		$Sprite.flip_h = global_position < dash_destination
	if (in_dash):
		direction = global_position.move_toward(dash_destination, dash_speed * delta) - global_position
		velocity = direction / delta
		if direction.is_zero_approx():
			in_dash = false
			set_collision_layer_value(5, false)
	else:
		direction.x = Input.get_axis("move_left", "move_right")
		direction.y = Input.get_axis("move_up", "move_down")
		direction = direction.normalized()
		velocity = direction * movement_speed
	move_and_slide()

func throw() -> void:
	if (brewed_potions[current_potion] < 1):
		return
	brewed_potions[current_potion] -= 1
	if (potion_timers[current_potion].is_stopped()):
		potion_timers[current_potion].start()
	var target_pos : Vector2 = get_global_mouse_position()
	var new_potion : Potion = potions[current_potion].new_potion(target_pos)
	new_potion.global_position = global_position
	get_tree().current_scene.add_child(new_potion)
	updated_potion.emit()
	$ActionTimer.start()
	$Sprite.play("throw")
	$Sprite.flip_h = global_position < target_pos

func switch_potion() -> void:
	if (current_potion < potions.size() - 1):
		current_potion += 1
	else:
		current_potion = 0
	switched_potion.emit()

func brew_potion(potion_type: int) -> void:
	brewed_potions[potion_type] += 1
	if (brewed_potions[potion_type] < potion_limits[potion_type]):
		potion_timers[potion_type].start()
	updated_potion.emit()

func lose_potion() -> int:
	if (brewed_potions[0] == -1 and brewed_potions[1] == -1 and brewed_potions[2] == -1 and brewed_potions[3] == -1):
		die()
		return -1
	set_collision_layer_value(3, false)
	$GracePeriodTimer.start()
	var lose: int = randi_range(0, 3)
	while (brewed_potions[lose] == -1):
		lose = randi_range(0, 3)
	potion_timers[lose].stop()
	brewed_potions[lose] = -1
	updated_potion.emit()
	return lose

func pick_up_potion(potion_type: int) -> void:
	brewed_potions[potion_type] = 0
	potion_timers[potion_type].start()
	updated_potion.emit()

func _on_dash_timer_timeout() -> void:
	in_dash = false
	set_collision_layer_value(5, false)

func fall_in_hole() -> void:
	die()

func die() -> void:
	set_deferred("process_mode", PROCESS_MODE_DISABLED)
	$Sprite.hide()

func _on_grace_period_timer_timeout() -> void:
	set_collision_layer_value(3, true)
