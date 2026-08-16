extends Control

@export var end_text : Label

signal restart_game

func set_end_text(text:String) -> void:
	end_text.text = text

func _on_button_pressed() -> void:
	emit_signal('restart_game')
