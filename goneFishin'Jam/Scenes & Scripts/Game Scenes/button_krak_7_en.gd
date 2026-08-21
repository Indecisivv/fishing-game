extends TextureButton


func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(0.429, 0.429), 0.4)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(0.379, 0.379), 0.4)


func _on_pressed() -> void:
	OS.shell_open("https://itch.io/profile/krak7en")
