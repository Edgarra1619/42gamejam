class_name Potion
extends Area2D

const	ROTATION_SPEED = 8
const	MAX_SPEED = 300

static var potion : PackedScene = preload("res://scenes/potion.tscn")
static var splash : PackedScene = preload("res://scenes/potion.tscn")

var target_position : Vector2

static func new_potion(pos : Vector2) -> Potion:
	var newpot : Potion = potion.instantiate()
	newpot.target_position = pos
	return newpot

func _process(delta: float) -> void:
	rotate(delta * ROTATION_SPEED)

func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target_position, delta * MAX_SPEED)
	if (global_position.is_equal_approx(target_position)):
		_explode();

func _explode() -> void:
	var splash_node := splash.instantiate()
	splash_node.global_position = global_position
	get_tree().current_scene.add_child(splash_node)
	queue_free()

func _on_body_entered(_body:Node2D) -> void:
	_explode()

