extends Control

@onready var label_contact_name: Label = $BasePhone/Label_ContactName
@onready var texture_icon: TextureRect = $BasePhone/TextureIcon
@onready var icon_lineboil: AnimationPlayer = $BasePhone/IconLineboil

var unpause : bool = false

signal settings_opened

func _on_btn_entered() -> void:
	Dialogic.paused = true
	
func _on_btn_exited() -> void:
	if !unpause:
		return
	
	Dialogic.paused = false

func load_timeline(timeline:String) -> void:
	if Dialogic.current_timeline:
		Dialogic.end_timeline(true)
	Dialogic.start(timeline)

func set_contact(_name:String, anim:String) -> void:
	label_contact_name.text = _name
	icon_lineboil.play(anim)

func _on_can_unpause() -> void:
	unpause = true

func on_btn_settings_pressed() -> void:
	unpause = false
	emit_signal('settings_opened')
