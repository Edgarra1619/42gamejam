class_name Player
extends CharacterBody2D

signal switched_potion
signal threw_potion
signal brewed_potion

static var player : Player

@export var movement_speed: int = 800
@export var dash_speed: int = 8000
var in_dash: bool = false
var dash_destination: Vector2

const potion_limits: Array = [3, 1, 1, 1]
static var potions: Array = [RedPotion, PurplePotion, GreenPotion, GoldPotion]
var potion_timers: Array
var brewed_potions: Array = potion_limits.duplicate(true)
var current_potion: int = 0

func _ready() -> void:
	player = self
	potion_timers = [$RedPotionTimer, $PurplePotionTimer, $GreenPotionTimer, $GoldPotionTimer]
	pass

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("throw_potion")):
		throw()
	if (Input.is_action_just_pressed("switch_potion")):
		switch_potion()

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	if (Input.is_action_just_pressed("dash") and $DashCooldownTimer.is_stopped()):
		in_dash = true
		set_collision_layer_value(5, true)
		dash_destination = get_global_mouse_position()
		$DashTimer.start()
		$DashCooldownTimer.start()
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
	var pos : Vector2 = get_global_mouse_position()
	var new_potion : Potion = potions[current_potion].new_potion(pos)
	get_tree().current_scene.add_child(new_potion)
	new_potion.global_position = global_position
	threw_potion.emit()

func switch_potion() -> void:
	if (current_potion < potions.size() - 1):
		current_potion += 1
	else:
		current_potion = 0
	switched_potion.emit()

func brew_potion(i: int) -> void:
	brewed_potions[i] += 1
	if (brewed_potions[i] < potion_limits[i]):
		potion_timers[i].start()
	brewed_potion.emit()

func _brew_red_potion() -> void:
	brew_potion(0)

func _brew_purple_potion() -> void:
	brew_potion(1)

func _brew_green_potion() -> void:
	brew_potion(2)

func _brew_gold_potion() -> void:
	brew_potion(3)

func lose_potion() -> void:
	if (brewed_potions[0] == -1 and brewed_potions[1] == -1 and brewed_potions[2] == -1 and brewed_potions[3] == -1):
		die()
		return
	var lose: int = randi_range(0, 3)
	while (brewed_potions[lose] == -1):
		lose = randi_range(0, 3)
	potion_timers[lose].stop()
	brewed_potions[lose] = -1

func _on_dash_timer_timeout() -> void:
	in_dash = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	lose_potion()
	$Hurtbox.set_collision_mask_value(2, false)
	$GracePeriodTimer.start()
	brewed_potion.emit()

func fall_in_hole() -> void:
	die()

func die() -> void:
	set_deferred("process_mode", PROCESS_MODE_DISABLED)
	$Sprite2D.hide()

func _on_grace_period_timer_timeout() -> void:
	$Hurtbox.set_collision_mask_value(2, true)
