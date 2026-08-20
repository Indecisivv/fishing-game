extends Control

@onready var vn_settings_btn_layer: CanvasLayer = $CanvasLayer
@onready var settings: TextureButton = $CanvasLayer/Settings

var tween : Tween
var can_unpause : bool

signal settings_opened

func _on_btn_entered() -> void:
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(settings, "scale", Vector2(1.1, 1.1), 0.4)
	
func _on_btn_pressed() -> void:
	can_unpause = false
	emit_signal('settings_opened')
	
func _on_btn_exited() -> void:
	reset_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(settings, "scale", Vector2.ONE, 0.4)
	
func show_button(_show:bool) -> void:
	vn_settings_btn_layer.visible = _show

func _on_can_unpause() -> void:
	can_unpause = true

func reset_tween() -> void:
	if (tween):
		tween.kill()
	tween = create_tween()
