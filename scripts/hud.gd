class_name Hud
extends Control

@export var player: Player

func update_current_potion() -> void:
	$CurrentPotion.text = str("Current Potion: ", player.current_potion)

func update_potion_counts() -> void:
	$RedPotionsCount.text = str("Red Potions: ", player.brewed_potions[0])
	$PurplePotionsCount.text = str("Purple Potions: ", player.brewed_potions[1])
	$GreenPotionsCount.text = str("Green Potions: ", player.brewed_potions[2])
	$GoldPotionsCount.text = str("Gold Potions: ", player.brewed_potions[3])
