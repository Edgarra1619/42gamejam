class_name Banker
extends Enemy

@export var	escape_routes: Array
var			target_escape: Node2D
var			potion_held: int = -1

func _ready() -> void:
	$Sprite2D.modulate = Color.DEEP_PINK
	health = 6
	movement_speed = 450
	cause_rush_chance = 35
	enemy_type = 2
	super()

func _process(delta: float) -> void:
	if (health <= 0 and potion_held != -1):
		var dropped_potion = preload("res://scenes/dropped_potion.tscn").instantiate()
		dropped_potion.set_potion_type(potion_held)
		dropped_potion.global_position = global_position
		get_tree().current_scene.add_child(dropped_potion)
	super(delta)

func _on_body_entered(body: Node) -> void:
	if (body is Player and potion_held == -1):
		potion_held = body.lose_potion()
		if (potion_held != -1):
			movement_speed = 350
			choose_escape()

func choose_escape() -> void:
	if (escape_routes.is_empty()):
		escape_routes = Game.game.doors
	var	closest = INF
	target = escape_routes[0]
	for exit in escape_routes:
		var	distance = global_position.distance_to(exit.global_position)
		if distance < closest:
			closest = distance
			target = exit

func flee() -> void:
	queue_free()
