extends Control

@export var start_button : Button

signal game_started

func _on_start_button_pressed() -> void:
	emit_signal('game_started')
