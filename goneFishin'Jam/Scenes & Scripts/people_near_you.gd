extends Control

@export var buttons : Array[Button]

signal date_selected
signal all_chars_dated

var index : int = 0

func disable_button() -> void:
	buttons[index].disabled = true
	check_buttons()

func check_buttons() -> void:
	for i in buttons.size():
		if buttons[i].disabled:
			continue
		else:
			return
	
	emit_signal('all_chars_dated')

# TO-DO: change method name to use name of corresponding character
func _on_character1_pressed() -> void:
	index = 0
	emit_signal('date_selected')

# TO-DO: change method name to use name of corresponding character
func _on_character2_pressed() -> void:
	index = 1
	emit_signal('date_selected')

# TO-DO: change method name to use name of corresponding character
func _on_character3_pressed() -> void:
	index = 2
	emit_signal('date_selected')
