extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal transition_finished

func _ready() -> void:
	color_rect.hide()
	
func _on_animation_finished(anim_name:StringName) -> void:
	if anim_name == "fade_to_black":
		emit_signal("transition_finished")
		fade_to_normal()
	elif anim_name == "fade_to_normal":
		color_rect.hide()

func fade_to_black() -> void:
	color_rect.show()
	animation_player.play("fade_to_black")

func fade_to_normal() -> void:
	color_rect.show()
	animation_player.play("fade_to_normal")
