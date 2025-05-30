extends CharacterBody2D

@export var movement_speed: int = 400

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if (Player.player):
		var direction = global_position.move_toward(Player.player.global_position, movement_speed * delta) - global_position
		velocity = direction / delta
	move_and_slide()
