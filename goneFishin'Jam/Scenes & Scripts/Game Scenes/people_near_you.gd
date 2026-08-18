extends Control

@export var buttons : Array[TextureButton]
@export var phone   : Control

@onready var date_choices_view    : Control         = $Phone/DateChoicesView
@onready var date_profile_view    : Control         = $Phone/DateProfileView
@onready var btn_dead_line_boiler : AnimationPlayer = $Phone/DateChoicesView/BtnDeadLineBoiler

signal date_selected
signal all_chars_dated

var index           : int     = 0
var target_position : Vector2 = Vector2(657, 0)
var target_rotation : float   = 0.0

func _on_btn_ada_pressed() -> void:
	index = 0
	emit_signal('date_selected')
	reset_screen()

func _on_btn_soccoro_pressed() -> void:
	index = 1
	emit_signal('date_selected')
	reset_screen()

func _on_btn_khanh_pressed() -> void:
	index = 2
	emit_signal('date_selected')
	reset_screen()
	
func _on_return_to_date_choices() -> void:
	reset_screen()

func enter_phone() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(phone, "global_position", target_position, 1.5)
	tween.tween_property(phone, "rotation_degrees", target_rotation, 1.5)

func disable_button() -> void:
	buttons[index].disabled = true
	buttons[index].modulate = Color("777777")
	
	match index:
		0:
			btn_dead_line_boiler.get_animation("btn_line_boil_dead").track_set_enabled(0, true)
		1:
			btn_dead_line_boiler.get_animation("btn_line_boil_dead").track_set_enabled(1, true)
		2:
			btn_dead_line_boiler.get_animation("btn_line_boil_dead").track_set_enabled(2, true)
	
	btn_dead_line_boiler.play("btn_line_boil_dead")
	check_buttons()

func reset_all_buttons() -> void:
	for i in buttons.size():
		buttons[i].disabled = false
		buttons[i].modulate = Color("ffffff")
		btn_dead_line_boiler.get_animation("btn_line_boil_dead").track_set_enabled(i, false)

func check_buttons() -> void:
	for i in buttons.size():
		if buttons[i].disabled:
			continue
		else:
			return
	
	emit_signal('all_chars_dated')

func reset_screen() -> void:
	date_choices_view.show()
	date_profile_view.hide()
