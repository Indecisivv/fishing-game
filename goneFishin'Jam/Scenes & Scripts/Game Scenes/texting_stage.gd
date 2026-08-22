extends Control

@onready var label_contact_name: Label = $BasePhone/Label_ContactName
@onready var texture_icon: TextureRect = $BasePhone/TextureIcon
@onready var icon_lineboil: AnimationPlayer = $BasePhone/IconLineboil
@onready var button_settings: TextureButton = $"UI Features/Button_Settings"

var unpause : bool = true

signal settings_opened

func _on_btn_entered() -> void:
	Dialogic.paused = true
	print("Entered: " + str(Dialogic.paused))
	
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(button_settings, "scale", Vector2(1.1, 1.1), 0.4)
	
func _on_btn_exited() -> void:
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(button_settings, "scale", Vector2.ONE, 0.4)
	
	if !unpause:
		return
	
	Dialogic.paused = false
	print("Exited: " + str(Dialogic.paused))

func load_timeline(timeline:String) -> void:
	if Dialogic.current_timeline:
		Dialogic.end_timeline(true)

	Dialogic.start(timeline)

func set_contact(_name:String, anim:String) -> void:
	label_contact_name.text = _name
	icon_lineboil.play(anim)

func _on_can_unpause() -> void:
	await get_tree().create_timer(0.1).timeout
	
	unpause = true
	button_settings.mouse_exited.emit()

func on_btn_settings_pressed() -> void:
	unpause = false
	emit_signal('settings_opened')
	print("Pressed: " + str(Dialogic.paused))
