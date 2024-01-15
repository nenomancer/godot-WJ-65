extends MarginContainer
signal color_clicked

@onready var button_color = $Color
@onready var button_sound = $Sound
@onready var button_label = $NoteName
var is_hovered: bool = false

var color_value: Color
var color_hover: Color 

@export var current_sound: AudioStreamWAV
@export var current_color: Color

func _ready():
	if current_color != Color.BLACK:
		button_color.color = current_color
	if current_sound != null:
		button_sound.stream = current_sound
		
	color_value = button_color.color
	color_hover = color_value.lightened(0.25)

func configure_button(audio: AudioStreamWAV, fill_color: Color, text: String, text_color: Color):
	$Sound.stream = audio
	$Color.color = fill_color
	$NoteName.text = text
	$NoteName.label_settings.font_color = text_color

func _on_button_button_up():
	button_sound.playing = true
	color_clicked.emit()

func _on_button_mouse_entered():
	button_color.color = color_hover

func _on_button_mouse_exited():
	button_color.color = color_value
