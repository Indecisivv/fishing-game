extends Control

@onready var date_fail    : Control           = $DateFail
@onready var date_success : Control           = $DateSuccess
@onready var cg_rect      : TextureRect       = $DateSuccess/CGRect
@onready var end_text     : Label             = $DateSuccess/VBoxContainer/EndText
@onready var end_subtitle : Label             = $DateSuccess/VBoxContainer/EndSubtitle
@onready var fail_text    : Label             = $DateFail/FailText
@onready var unmatch      : AudioStreamPlayer = $DateSuccess/unmatch
@onready var cg_player    : AnimationPlayer   = $DateSuccess/AnimationPlayer
@onready var dish_bgm     : AudioStreamPlayer = $DateSuccess/dish_bgm

signal on_return

const BG_DINNER_1 = preload("uid://tnfg1so6udsf")
const BG_DINNER_2 = preload("uid://drdcns0eeiqdy")
const BG_DINNER_3 = preload("uid://da3frm01gr4or")

# Changes the CG
func set_cg(win:bool, anim_name:String = "") -> void:
	if win:
		cg_player.play(anim_name)
		
		date_fail.hide()
		date_success.show()
	else:
		date_fail.show()
		date_success.hide()

# Changes the text
func set_win_text(title_text:String, subtitle_text:String = "") -> void:
	end_text.text = title_text
	end_subtitle.text = subtitle_text

func set_lose_text(_text:String) -> void:
	fail_text.text = _text

func play_music() -> void:
	dish_bgm.volume_db = -20.444
	dish_bgm.play()

func on_main_menu_button_pressed() -> void:
	dish_bgm.stop()
	emit_signal('on_return')
