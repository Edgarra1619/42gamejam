class_name Hud
extends CanvasLayer

func update_current_potion() -> void:
	
	pass

func _calc_fillness(index : int) -> float:
	var filled : float = Player.player.brewed_potions[index] as float / Player.player.potion_limits[index] as float
	if (filled != 1):
		filled += (1 - Player.player.potion_timers[index].time_left / Player.player.potion_timers[index].wait_time) / Player.player.potion_limits[index]
	return filled

func _process(_delta : float):
	$"Potions/RedPotion/Active/Control".size.y = lerp(27, 6, _calc_fillness(0))
	if (Player.player.brewed_potions[0] == -1):
		$"Potions/RedPotion/Inactive".show()
	else:
		$"Potions/RedPotion/Inactive".hide()
	$"Potions/PurplePotion/Active/Control".size.y = lerp(27, 6, _calc_fillness(1))
	if (Player.player.brewed_potions[1] == -1):
		$"Potions/PurplePotion/Inactive".show()
	else:
		$"Potions/PurplePotion/Inactive".hide()
	$"Potions/GreenPotion/Active/Control".size.y = lerp(27, 6, _calc_fillness(2))
	if (Player.player.brewed_potions[2] == -1):
		$"Potions/GreenPotion/Inactive".show()
	else:
		$"Potions/GreenPotion/Inactive".hide()
	$"Potions/GoldPotion/Active/Control".size.y = lerp(27, 6, _calc_fillness(3))
	if (Player.player.brewed_potions[3] == -1):
		$"Potions/GoldPotion/Inactive".show()
	else:
		$"Potions/GoldPotion/Inactive".hide()
	$"Buckle".position.x = lerp($"Buckle".position.x, 18 + Player.player.current_potion * 56.0, 10 * _delta)


func update_potion_counts() -> void:
	$VBoxContainer/RedPotionsCount.text = str("Red Potions: ", Player.player.brewed_potions[0])
	$VBoxContainer/PurplePotionsCount.text = str("Purple Potions: ", Player.player.brewed_potions[1])
	$VBoxContainer/GreenPotionsCount.text = str("Green Potions: ", Player.player.brewed_potions[2])
	$VBoxContainer/GoldPotionsCount.text = str("Gold Potions: ", Player.player.brewed_potions[3])
