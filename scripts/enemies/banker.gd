class_name Banker
extends Enemy

@export var	escape_routes: Array[Node2D]
var			target_escape: Node2D

func _on_body_entered(body: Node) -> void:
	if body is Player:
		#body.lose_potion() <- TODO
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
