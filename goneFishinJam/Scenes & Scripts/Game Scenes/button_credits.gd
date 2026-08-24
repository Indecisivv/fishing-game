extends TextureButton
@onready var hover_sound: AudioStreamPlayer = $"../../../../HoverSound"
@onready var click_sound: AudioStreamPlayer = $"../../../../PlaySound"

func _on_pressed() -> void:
	click_sound.play()
	
func _on_mouse_entered() -> void:
	hover_sound.play()
	
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.4)

func _on_mouse_exited() -> void:
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.4)
