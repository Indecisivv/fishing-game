extends Control

@onready var match_icon_lineboiler: AnimationPlayer = $MatchIconLineboiler

var animation : String


func set_icon(anim_name:String) -> void:
	animation = anim_name 
	match_icon_lineboiler.play(anim_name)  
	
	
	
