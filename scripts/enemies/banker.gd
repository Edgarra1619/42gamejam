class_name Banker
extends Enemy

@export var	escape_routes: Array[Node2D]
var			target_escape: Node2D
enum		Goal { CHASE, ESCAPE }
var			goal = Goal.CHASE

func _physics_process(delta: float) -> void:
	if goal == Goal.CHASE:
		super(delta)
	else:
		var direction = global_position.move_toward(target_escape.global_position, movement_speed * delta) - global_position
		velocity = direction / delta
		move_and_slide()
	if goal == Goal.ESCAPE && global_position.distance_to(target_escape.global_position) < 10:
		flee()

func _on_body_entered(body: Node) -> void:
	if body is Player and goal == Goal.CHASE:
		goal = Goal.ESCAPE
		#body.lose_potion() <- TODO
		choose_escape()
		
func choose_escape() -> void:
	var	closest = INF
	for exit in escape_routes:
		var	distance = global_position.distance_to(exit.global_position)
		if distance < closest:
			closest = distance
			target_escape = exit
			
func flee() -> void:
	queue_free()
