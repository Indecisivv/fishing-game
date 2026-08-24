extends Control

signal return_to_menu

func _on_menu_button_pressed() -> void:
	emit_signal('return_to_menu')
