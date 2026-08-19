extends TextureButton

@onready var btn_line_boiler       : AnimationPlayer = $"../BtnLineBoiler"
@onready var date_profile_view     : Control         = $"../../DateProfileView"

var btn_tween : Tween

func _on_btn_ada_entered() -> void:
	if (self.disabled):
		return
	
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(0.94, 0.94), 0.4)
	
	btn_line_boiler.get_animation('lineboil').track_set_enabled(0, false)
	
func _on_btn_ada_pressed() -> void:
	if (self.disabled):
		return
	
	self.get_parent().hide()
	date_profile_view.set_profile("lineboil_ada")
	date_profile_view.show()
	

func _on_btn_ada_exited() -> void:
	if (self.disabled):
		return
	
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(0.89, 0.89), 0.4)
	
	btn_line_boiler.get_animation('lineboil').track_set_enabled(0, true)
	
func reset_btn_tween() -> void:
	if btn_tween:
		btn_tween.kill()
	btn_tween = create_tween()
