extends CharacterBody2D

@export var movement_speed: int = 300
@export var potion: PackedScene

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("throw_potion"):
		var new_potion = potion.instantiate()
		new_potion.position = get_global_mouse_position()
		get_tree().current_scene.add_child(new_potion)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * movement_speed
	move_and_slide()
