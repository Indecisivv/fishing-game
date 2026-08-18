extends TextureButton

@onready var btn_line_boiler   : AnimationPlayer = $"../BtnLineBoiler"
@onready var date_profile_view : Control         = $"../../DateProfileView"

var btn_tween : Tween

func _on_btn_soccoro_entered() -> void:
	if (self.disabled):
		return
		
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(0.35, 0.35), 0.4)
	
	btn_line_boiler.play("btn_soccoro_line_boil")

func _on_btn_soccoro_pressed() -> void:
	if (self.disabled):
		return
	
	self.get_parent().hide()
	date_profile_view.set_profile("lineboil_soccoro")
	date_profile_view.show()

func _on_btn_soccoro_exited() -> void:
	if (self.disabled):
		return
		
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(0.3, 0.3), 0.4)
	
	btn_line_boiler.stop()
	
func reset_btn_tween() -> void:
	if (self.disabled):
		return
		
	if btn_tween:
		btn_tween.kill()
	btn_tween = create_tween()
