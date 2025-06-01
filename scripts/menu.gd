extends Control

@onready var selector_icon := $Selection
@onready var buttons := [$"VBoxContainer/Start Button", $"VBoxContainer/Quit Button"]

func _process(_delta: float) -> void:
	for button in buttons:
		if button.has_focus():
			var icon_pos = button.global_position
			icon_pos.x -= 35
			icon_pos.y += 32 
			selector_icon.global_position = icon_pos

func _ready() -> void:
	$"VBoxContainer/Start Button".grab_focus()
	selector_icon.play("walk")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
