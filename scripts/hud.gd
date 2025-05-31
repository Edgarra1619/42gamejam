class_name Hud
extends Control

func update_current_potion() -> void:
	$CurrentPotion.text = str("Current Potion: ", Player.player.current_potion)

func update_potion_counts() -> void:
	$RedPotionsCount.text = str("Red Potions: ", Player.player.brewed_potions[0])
	$PurplePotionsCount.text = str("Purple Potions: ", Player.player.brewed_potions[1])
	$GreenPotionsCount.text = str("Green Potions: ", Player.player.brewed_potions[2])
	$GoldPotionsCount.text = str("Gold Potions: ", Player.player.brewed_potions[3])
