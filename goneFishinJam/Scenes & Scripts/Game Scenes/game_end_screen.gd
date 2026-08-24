extends Control

@onready var all_caught_text    : Control = $AllCaughtText
@onready var one_more_bite_text : Control = $OneMoreBiteText
@onready var one_caught_text    : Control = $OneCaughtText
@onready var no_pull_text       : Control = $NoPullText
@onready var end_bg       : Control = $TextureRect

@onready var ending_label : Label = $EndingLabel
@onready var ending_title : Label = $EndingTitle

@onready var animation_player : AnimationPlayer   = $AnimationPlayer
@onready var ending_music     : AudioStreamPlayer = $EndingMusic


signal restart_game
signal quit_game

func _on_btn_cast_again_pressed() -> void:
	#no_pull_text.hide()
	#one_caught_text.hide()
	#one_more_bite_text.hide()
	#all_caught_text.hide()
	#end_bg.hide()
	ending_music.stop()
	emit_signal('restart_game')

func _on_btn_quit_pressed() -> void:
	ending_music.stop()
	emit_signal('quit_game')

func set_cg(anim_name:String) -> void:
	animation_player.play(anim_name)

func play_music() -> void:
	ending_music.volume_db = -20.444
	ending_music.play()

func set_end_text(num:int) -> void:
	match num:
		0:
			no_pull_text.show()
			one_caught_text.hide()
			one_more_bite_text.hide()
			all_caught_text.hide()
		1:
			no_pull_text.hide()
			one_caught_text.show()
			one_more_bite_text.hide()
			all_caught_text.hide()
		2:
			no_pull_text.hide()
			one_caught_text.hide()
			one_more_bite_text.show()
			all_caught_text.hide()
		3:
			no_pull_text.hide()
			one_caught_text.hide()
			one_more_bite_text.hide()
			all_caught_text.show()

func set_end_label(num:int) -> void:
	ending_label.text = tr("ENDING_END_LABEL") + str(num) + "/3"
	
	match num:
		0:
			ending_title.text = tr("ENDING_STARVING_LABEL")
		1:
			ending_title.text = tr("ENDING_UNSATISFIED_LABEL")
		2:
			ending_title.text = tr("ENDING_ROOM_LABEL")
		3:
			ending_title.text =tr("ENDING_GREED_LABEL")
