extends Control

signal game_started
signal gallery_entered
signal settings_entered
signal credits_entered

func _on_start_button_pressed() -> void:
	emit_signal('game_started')

func _on_gallery_button_pressed() -> void:
	emit_signal('gallery_entered')

func _on_settings_button_pressed() -> void:
	emit_signal('settings_entered')

func _on_credits_button_pressed() -> void:
	emit_signal('credits_entered')
