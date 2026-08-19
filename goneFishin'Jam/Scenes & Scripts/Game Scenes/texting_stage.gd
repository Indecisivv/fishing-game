extends Control

signal settings_opened
var unpause : bool = false

func load_timeline(timeline:String) -> void:
	if Dialogic.current_timeline:
		Dialogic.end_timeline(true)
	Dialogic.start(timeline)

func _on_btn_entered() -> void:
	Dialogic.paused = true
	
func _on_btn_exited() -> void:
	if !unpause:
		return
	
	Dialogic.paused = false

func _on_can_unpause() -> void:
	unpause = true

func on_btn_settings_pressed() -> void:
	unpause = false
	emit_signal('settings_opened')
