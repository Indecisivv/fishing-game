extends Control

signal game_started
signal settings_entered
signal credits_entered
signal quit_pressed

func _on_start_button_pressed() -> void:
	emit_signal('game_started')

func _on_settings_button_pressed() -> void:
	emit_signal('settings_entered')

func _on_credits_button_pressed() -> void:
	emit_signal('credits_entered')

func _on_quit_button_pressed() -> void:
	emit_signal('quit_pressed')
