class_name Miner
extends Enemy

func _ready() -> void:
	$Sprite2D.modulate = Color.SALMON
	movement_speed = 350 # slower enemy at first
	health = 10

func _process(delta: float) -> void:
	super(delta)
	if health <= 5:
		rage_mode()
		
func rage_mode() -> void:
	movement_speed = 650
	$Sprite2D.modulate = Color.RED
