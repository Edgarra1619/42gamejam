class_name Banker
extends Enemy

@export var	escape_routes: Array[Node2D]
var			target_escape: Node2D

func _ready() -> void:
	$Sprite2D.modulate = Color.DEEP_PINK
	health = 6
	movement_speed = 450
	super()

func _on_body_entered(body: Node) -> void:
	if body is Player:
		#body.lose_potion() <- TODO
		movement_speed = 350
		choose_escape()
		
func choose_escape() -> void:
	var	closest = INF
	target = escape_routes[0]
	for exit in escape_routes:
		var	distance = global_position.distance_to(exit.global_position)
		if distance < closest:
			closest = distance
			target = exit
			
func flee() -> void:
	queue_free()
