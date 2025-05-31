class_name Potion
extends Area2D

const	ROTATION_SPEED = 8
const	MAX_SPEED = 300

static var potion : PackedScene = preload("res://scenes/potion.tscn")

@onready var dest_clock: Timer = Timer.new()
var target_position : Vector2
var impact_damage: int
var has_exploded: bool = false

static func new_potion(pos: Vector2) -> Potion:
	var newpot : Potion = potion.instantiate()
	newpot.target_position = pos
	return newpot

func _ready() -> void:
	add_child(dest_clock)

func _process(delta: float) -> void:
	if (dest_clock.is_stopped()):
		rotate(delta * ROTATION_SPEED)

func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target_position, delta * MAX_SPEED)
	if (global_position.is_equal_approx(target_position)):
		_explode();

func _explode() -> void:
	rotation = 0
	dest_clock.wait_time = 5
	$GPUParticles2D.emitting = true
	$Sprite2D.hide()
	dest_clock.timeout.connect(func ():
		queue_free()
	)
	dest_clock.start()
	has_exploded = true

func _on_body_entered(_body: Node2D) -> void:
	_explode()
	_body.receive_damage(impact_damage)
