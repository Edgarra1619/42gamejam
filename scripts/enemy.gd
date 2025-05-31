class_name Enemy
extends CharacterBody2D

@export var movement_speed: int = 400
var health: int = 3
var is_slowed: bool = false
var goldified: bool = false
var gold_timer: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if (health <= 0):
		_die()
	if goldified:
		gold_timer -= delta
		if gold_timer <= 0:
			break_free()

func _physics_process(delta: float) -> void:
	if (goldified):
		velocity = Vector2.ZERO
	elif (Player.player):
		var direction = global_position.move_toward(Player.player.global_position, movement_speed * delta) - global_position
		velocity = direction / delta
		if (is_slowed):
			velocity /= 2
	move_and_slide()

func _die() -> void:
	$Sprite2D.hide()
	process_mode = PROCESS_MODE_DISABLED
	queue_free()

func receive_damage(damage: int) -> void:
	health -= damage

func turn_gold() -> void:
	var duration: float = 5.0
	#duration -= health
	#if (duration <= 0): Turn on if we decide to go back to gold time depending on health
	#	return
	goldified = true
	gold_timer = duration
	velocity = Vector2.ZERO
	$Sprite2D.modulate = Color.GOLD
	
func break_free():
	goldified = false
	$Sprite2D.modulate = Color.WHITE
	
func get_poisoned() -> void:
	$Sprite2D.modulate = Color(0.5, 0, 0.5, 1)
	$PoisonDamageTimer.start()

func _receive_poison_damage() -> void:
	receive_damage(1)

func get_slowed() -> void:
	is_slowed = true
	$SlowTimer.start()
	$SlowTimer.timeout.connect(func():
		is_slowed = false
	)
