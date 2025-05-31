class_name Miner
extends Enemy

func _ready() -> void:
	movement_speed = 350 # slower enemy at first
	health = 9

func _process(delta: float) -> void:
	super(delta)
	if health <= 5:
		rage_mode()
		
func rage_mode() -> void:
	movement_speed = 450
	$Sprite2D.modulate = Color.RED
