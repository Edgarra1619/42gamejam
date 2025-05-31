class_name Enemy
extends CharacterBody2D

@export var 	movement_speed: int = 400
@onready var	gold_rush_aoe: Area2D = $GoldRushAOE
var 			health: int = 3
var				is_slowed: bool = false
var				goldified: bool = false
var				cause_rush_chance: int
var				target: Node2D

func _ready() -> void:
	if Player.player:
		target = Player.player

func _process(_delta: float) -> void:
	if (health <= 0):
		_die()

func _physics_process(delta: float) -> void:
	if (goldified):
		velocity = Vector2.ZERO
	elif target:
		var direction = global_position.move_toward(target.global_position, movement_speed * delta) - global_position
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

func turn_gold() -> void:
	if goldified:
		return
	goldified = true
	$Sprite2D.modulate = Color.GOLD
	$GoldTimer.start()
	activate_gold_rush()

func activate_gold_rush() -> void:
	gold_rush_aoe.monitoring = true
	await get_tree().process_frame
	var fools = gold_rush_aoe.get_overlapping_bodies()
	for fool in fools:
		if fool is Banker and fool != self:
			if randi () % 150 < self.cause_rush_chance:
				fool.get_gold_rush(self)
		elif fool is Peasant and fool != self:
			if randi() % 100 < self.cause_rush_chance:
				fool.get_gold_rush(self)
	gold_rush_aoe.monitoring = false

func get_gold_rush(gold_enemy: Enemy) -> void:
	if goldified:
		return
	$GoldRushTimer.start()
	target = gold_enemy

func _end_gold_rush() -> void:
	if Player.player:
		target = Player.player
