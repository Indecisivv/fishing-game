extends Control

@export var buttons : Array[TextureButton]
@export var phone   : Control


@onready var ui_features          : Control = $"Phone/UI Features"
@onready var date_choices_view    : Control = $Phone/DateChoicesView
@onready var date_profile_view    : Control = $Phone/DateProfileView
@onready var match_screen         : Control = $Phone/MatchScreen
@onready var label_3_online       : Label   = $Phone/DateChoicesView/Label_3Online
@onready var button_app_logo: TextureButton = $"Phone/UI Features/Button_AppLogo"
@onready var button_heart: TextureButton = $Phone/DateProfileView/Button_Heart

@export var texture_loading_screen: TextureRect
@export var jingle: AudioStreamPlayer
@export var loading_screen_boiler: AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


signal date_selected
signal all_chars_dated
signal return_to_menu
signal open_settings
signal tween_finished

var index            : int     = 0
var initial_position : Vector2 = Vector2(-737, 1117)
var target_position  : Vector2 = Vector2(657, 0)
var initial_rotation : float   = -22.5
var target_rotation  : float   = 0.0

func _on_btn_ada_pressed() -> void:
	index = 0
	emit_signal('date_selected')
	reset_screen()

func _on_btn_khanh_pressed() -> void:
	index = 1
	emit_signal('date_selected')
	reset_screen()

func _on_btn_soccoro_pressed() -> void:
	index = 2
	emit_signal('date_selected')
	reset_screen()
	
func _on_return_to_date_choices() -> void:
	button_heart.modulate = Color("ffffff")
	button_app_logo.modulate = Color("ffffff")
	button_app_logo.disabled = false
	reset_screen()

func _on_return_to_menu() -> void:
	emit_signal("return_to_menu")

func _on_open_settings() -> void:	
	emit_signal("open_settings")

# Handles the tweening of the phone
func enter_phone() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(phone, "global_position", target_position, 1.5)
	tween.tween_property(phone, "rotation_degrees", target_rotation, 1.5)
	
	await tween.finished
	
	emit_signal("tween_finished")

# Resets the phone's position and rotation
func reset_phone() -> void:
	phone.position = initial_position
	phone.rotation_degrees = initial_rotation

# Handles the tweening for the loading screen
func loading_screen() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(texture_loading_screen, "modulate:a", 1, 1.4)
	
	await tween.finished
	
	jingle.play()
	
	await get_tree().create_timer(1.4).timeout
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(texture_loading_screen, "modulate:a", 0, 1.4)
	
	await tween.finished
	
	texture_loading_screen.hide()
	ui_features.show()
	date_choices_view.show()
	
	button_app_logo.can_press = true

# Resets the scenes back to their default states
func reset_loading_screen() -> void:
	texture_loading_screen.show()
	ui_features.hide()
	date_choices_view.hide()
	date_profile_view.hide()

# Disables a button and alters its visuals accordingly
func disable_button() -> void:
	buttons[index].disabled = true
	buttons[index].modulate = Color("777777")
	
	check_buttons()

# Resets all buttons and associated visual changes
func reset_all_buttons() -> void:
	for i in buttons.size():
		buttons[i].disabled = false
		buttons[i].modulate = Color("ffffff")

# Checks if all buttons are disabled to see if all characters have been dated
func check_buttons() -> void:
	for i in buttons.size():
		if buttons[i].disabled:
			continue
		else:
			return
	
	emit_signal('all_chars_dated')

# Takes the player back to the date choices view from the date profile view
func reset_screen() -> void:
	date_choices_view.show()
	ui_features.show()
	date_profile_view.hide()
	match_screen.hide()
	button_app_logo.modulate = Color("ffffff")
	button_app_logo.disabled = false

func set_people_online(num:int) -> void:
	label_3_online.text = str(num) + " online"
