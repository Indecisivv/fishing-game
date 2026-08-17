extends Control

@export var buttons : Array[Button]
@export var phone: Control

signal date_selected
signal all_chars_dated

var index           : int     = 0
var target_position : Vector2 = Vector2(657, 0)
var target_rotation : float = 0.0

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

func enter_phone() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(phone, "global_position", target_position, 1.5)
	tween.tween_property(phone, "rotation_degrees", target_rotation, 1.5)

func disable_button() -> void:
	buttons[index].disabled = true
	print(buttons[index].disabled)
	check_buttons()

func reset_all_buttons() -> void:
	for i in buttons.size():
		buttons[i].disabled = false

func check_buttons() -> void:
	for i in buttons.size():
		if buttons[i].disabled:
			continue
		else:
			return
	
	emit_signal('all_chars_dated')
