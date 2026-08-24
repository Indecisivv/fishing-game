extends Node
class_name CharacterClass

var char_name : String
var age       : String
var job       : String
var bio       : String

func _init(_name:String = "", _age:String = "", _job:String = "", _bio:String = "") -> void:
	self.char_name = _name
	self.age       = _age
	self.job       = _job
	self.bio       = _bio
