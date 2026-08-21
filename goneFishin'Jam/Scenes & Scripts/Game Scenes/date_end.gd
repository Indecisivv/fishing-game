extends Control

@onready var cg_rect: TextureRect = $CGRect
@onready var end_text: Label = $VBoxContainer/EndText
@onready var end_subtitle: Label = $VBoxContainer/EndSubtitle
@onready var unmatch: AudioStreamPlayer = $unmatch

signal on_retry
signal on_return_to_main_menu

const BG_DINNER_1 = preload("uid://tnfg1so6udsf")
const BG_DINNER_2 = preload("uid://drdcns0eeiqdy")
const BG_DINNER_3 = preload("uid://da3frm01gr4or")

# Changes the CG
func set_cg(cg:CompressedTexture2D) -> void:
	cg_rect.texture = cg

# Changes the text
func set_text(title_text:String, subtitle_text:String = "") -> void:
	end_text.text = title_text
	end_subtitle.text = subtitle_text

func on_retry_button_pressed() -> void:
	emit_signal('on_retry')

func on_main_menu_button_pressed() -> void:
	emit_signal('on_return_to_main_menu')
