extends TextureButton

signal ada
signal khanh
signal socorro

func _on_mouse_entered() -> void:
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.4)


func _on_mouse_exited() -> void:
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2.ONE, 0.4)


func _on_pressed() -> void:
	var anim_name = get_parent().animation
	
	match anim_name:
		"ada_icon":
			emit_signal('ada')
		"khanh_icon":
			emit_signal('khanh')
		"socorro_icon":
			emit_signal('socorro')
