extends Control

@export var date_end_text : Label

signal on_retry
signal on_return_to_main_menu

func set_date_text(text:String) -> void:
	date_end_text.text = text

func on_retry_button_pressed() -> void:
	emit_signal('on_retry')

func on_main_menu_button_pressed() -> void:
	emit_signal('on_return_to_main_menu')
