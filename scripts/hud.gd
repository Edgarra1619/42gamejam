class_name Hud
extends CanvasLayer

@onready var _max_width = $ColorRect.size.x

func update_current_potion() -> void:
	$VBoxContainer/CurrentPotion.text = str("Current Potion: ", Player.player.current_potion)
	match Player.player.current_potion:
		0:
			$"VBoxContainer/CurrentPotion/ColorRect".color = Color.RED
		1:
			$"VBoxContainer/CurrentPotion/ColorRect".color = Color.PURPLE
		2:
			$"VBoxContainer/CurrentPotion/ColorRect".color = Color.GREEN
		3:
			$"VBoxContainer/CurrentPotion/ColorRect".color = Color.GOLD

func _calc_fillness(index : int) -> float:
	var filled : float = Player.player.brewed_potions[index] as float / Player.player.potion_limits[index] as float
	if (filled != 1):
		filled += (1 - Player.player.potion_timers[index].time_left / Player.player.potion_timers[index].wait_time) / Player.player.potion_limits[index]
	return filled

func _process(_delta : float):
	#these ones have the future calculation for how filled the flask will be	
	$"VBoxContainer/RedPotionsCount/ColorRect".size.x = _max_width * (_calc_fillness(0))
	$"VBoxContainer/PurplePotionsCount/ColorRect".size.x = _max_width * (_calc_fillness(1))
	$"VBoxContainer/GreenPotionsCount/ColorRect".size.x = _max_width * (_calc_fillness(2))
	$"VBoxContainer/GoldPotionsCount/ColorRect".size.x = _max_width * (_calc_fillness(3))

#	$"VBoxContainer/RedPotionsCount/ColorRect".size.x = _max_width * (1.0 - (Player.player.potion_timers[0].time_left / Player.player.potion_timers[0].wait_time))
#	$"VBoxContainer/PurplePotionsCount/ColorRect".size.x = _max_width * (1.0 - (Player.player.potion_timers[1].time_left / Player.player.potion_timers[1].wait_time))
#	$"VBoxContainer/GreenPotionsCount/ColorRect".size.x = _max_width * (1.0 - (Player.player.potion_timers[2].time_left / Player.player.potion_timers[2].wait_time))
#	$"VBoxContainer/GoldPotionsCount/ColorRect".size.x = _max_width * (1.0 - (Player.player.potion_timers[3].time_left / Player.player.potion_timers[3].wait_time))


func update_potion_counts() -> void:
	$VBoxContainer/RedPotionsCount.text = str("Red Potions: ", Player.player.brewed_potions[0])
	$VBoxContainer/PurplePotionsCount.text = str("Purple Potions: ", Player.player.brewed_potions[1])
	$VBoxContainer/GreenPotionsCount.text = str("Green Potions: ", Player.player.brewed_potions[2])
	$VBoxContainer/GoldPotionsCount.text = str("Gold Potions: ", Player.player.brewed_potions[3])
