extends Control

@onready var cg_rect: TextureRect = $CGRect
@onready var end_text: Label = $EndText

signal on_retry
signal on_return_to_main_menu

const BG_DINNER_1 = preload("uid://dsehv58cy4f6b")
const BG_DINNER_2 = preload("uid://774pdj57xal0")
const BG_DINNER_3 = preload("uid://373c7gm6chbv")

# Changes the CG
func set_cg(cg:CompressedTexture2D) -> void:
	cg_rect.texture = cg

# Changes the text
func set_text(text:String) -> void:
	end_text.text = text

func on_retry_button_pressed() -> void:
	emit_signal('on_retry')

func on_main_menu_button_pressed() -> void:
	emit_signal('on_return_to_main_menu')
