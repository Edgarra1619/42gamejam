extends CharacterBody2D

@export var movement_speed: int = 400
var health: int = 3

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if (health <= 0):
		_die()

func _physics_process(delta: float) -> void:
	if (Player.player):
		var direction = global_position.move_toward(Player.player.global_position, movement_speed * delta) - global_position
		velocity = direction / delta
	move_and_slide()

func _die() -> void:
	$Sprite2D.hide()
	process_mode = PROCESS_MODE_DISABLED
	queue_free()

func receive_damage(damage: int) -> void:
	health -= damage

func get_poisoned() -> void:
	$Sprite2D.modulate = Color(0.5, 0, 0.5, 1)
	$PoisonDamageTimer.start()

func _receive_poison_damage() -> void:
	receive_damage(1)
