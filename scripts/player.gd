extends CharacterBody2D

@export var movement_speed: int = 300


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * movement_speed
	move_and_slide()
