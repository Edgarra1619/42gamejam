class_name Miner
extends Enemy

func _ready() -> void:
	$Sprite2D.modulate = Color.RED
	movement_speed = 350 # slower enemy at first
	health = 9
	cause_rush_chance = 50
	super()

func _process(delta: float) -> void:
	super(delta)
	if health <= 5:
		rage_mode()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		#Player.player.lose_potion()
		#Player.player.lose_potion() <- TODO
		pass
	pass

func rage_mode() -> void:
	movement_speed = 750
	$HoleTimer.start()
	$Sprite2D.modulate = Color.RED
	
func dig_hole() -> void:
	pass
