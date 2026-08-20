extends TextureButton

@onready var phone_line_boiler: AnimationPlayer = $"../../PhoneLineBoiler"
@onready var button_boiler: AnimationPlayer = $"../../ButtonBoiler"

var btn_tween : Tween

# Handles line boil and tweening
func _on_btn_entered() -> void:
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.4)
	
	phone_line_boiler.get_animation('bg_line_boil').track_set_enabled(1, false)
	button_boiler.play('logo_boiler')
	pass

func _on_btn_exited() -> void:
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(1, 1), 0.4)
	
	phone_line_boiler.get_animation('bg_line_boil').track_set_enabled(1, true)
	button_boiler.stop()
	pass
	
func reset_btn_tween() -> void:
	if btn_tween:
		btn_tween.kill()
	btn_tween = create_tween()
