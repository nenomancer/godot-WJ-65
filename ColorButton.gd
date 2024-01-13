extends MarginContainer

@onready var button_color = $Color
@onready var button_sound = $Sound

const AudioData = preload("res://Assets/AudioData.gd")
const ColorData = preload("res://Assets/ColorData.gd")

#const colors = [green, jade, turquoise, baby_blue, blue, purple, pink, salmon]
var colors: Array = ColorData.DATA
const sounds: Dictionary = AudioData.DATA
var index = 0

func _on_button_button_up():
	# Change color on button click
	$Sound.playing = true
	pass
