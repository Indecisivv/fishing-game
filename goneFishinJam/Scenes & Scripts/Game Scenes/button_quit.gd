extends TextureButton
@onready var hover_sound: AudioStreamPlayer = $"../../HoverSound"
@onready var quit_sound: AudioStreamPlayer = $"../../QuitSound"

func _on_pressed() -> void:
	quit_sound.play()
	
func _on_mouse_entered() -> void:
	hover_sound.play()
	
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(0.7, 0.7), 0.4)

func _on_mouse_exited() -> void:
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(0.6, 0.6), 0.4)
