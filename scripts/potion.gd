class_name Potion
extends Area2D

const	ROTATION_SPEED = 8
const	MAX_SPEED = 10

@export var splash : PackedScene

@onready var _sprite : Sprite2D = $"Sprite2D"

var target_position : Vector2

func	_init(pos : Vector2) -> void:
	target_position = pos

func	_process(delta: float) -> void:
	_sprite.rotate(delta * ROTATION_SPEED)

func	_physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target_position, delta * MAX_SPEED)
	if (global_position.is_equal_approx(target_position)):
		_explode();

func	_explode() -> void:
	var splash_node := splash.instantiate()
	splash_node.global_position = global_position
	get_tree().current_scene.add_child(splash_node)
	queue_free()

func	_on_body_entered(_body:Node2D) -> void:
	_explode()

