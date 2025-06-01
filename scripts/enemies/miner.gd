class_name Miner
extends Enemy

var in_rage: bool = false

func _ready() -> void:
	$Sprite2D.modulate = Color.RED
	movement_speed = 350 # slower enemy at first
	health = 9
	cause_rush_chance = 50
	super()

func _process(delta: float) -> void:
	super(delta)
	if (health <= 3 and not in_rage):
		rage_mode()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.lose_potion()

func rage_mode() -> void:
	in_rage = true
	movement_speed = 750
	$HoleTimer.start()
	$Sprite2D.modulate = Color.RED

func dig_hole() -> void:
	var hole = preload("res://scenes/hole.tscn").instantiate()
	hole.global_position = global_position
	get_tree().current_scene.add_child(hole)
