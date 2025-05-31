class_name Enemy
extends CharacterBody2D

@export var movement_speed: int = 400
@export var health: int = 3

var goldified: bool = false
var gold_timer: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if goldified:
		gold_timer -= delta;
		if gold_timer <= 0:
			break_free()
	if (health <= 0):
		_die()

func _physics_process(delta: float) -> void:
	if (goldified):
		velocity = Vector2.ZERO
	elif (Player.player):
		var direction = global_position.move_toward(Player.player.global_position, movement_speed * delta) - global_position
		velocity = direction / delta
	move_and_slide()

func _die() -> void:
	$Sprite2D.hide()
	process_mode = PROCESS_MODE_DISABLED
	queue_free()

func receive_damage(damage: int) -> void:
	health -= damage

func turn_gold(duration: float = 2.0) -> void:
	if (duration <= 1.0):
		return
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
