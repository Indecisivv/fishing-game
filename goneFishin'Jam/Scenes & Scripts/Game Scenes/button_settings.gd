extends TextureButton

@export var phone_line_boiler: AnimationPlayer

var btn_tween : Tween
var can_press : bool

# Handles line boil and tweening
func _on_btn_entered() -> void:
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.4)
	
	phone_line_boiler.get_animation('bg_line_boil').track_set_enabled(2, false)

func _on_btn_exited() -> void:
	reset_btn_tween()
	btn_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	btn_tween.tween_property(self, "scale", Vector2(1, 1), 0.4)
	
	phone_line_boiler.get_animation('bg_line_boil').track_set_enabled(2, true)
	
func reset_btn_tween() -> void:
	if btn_tween:
		btn_tween.kill()
	btn_tween = create_tween()
