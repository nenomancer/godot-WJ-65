extends MarginContainer
signal color_clicked(button)

@onready var button = $Container/Color.color
@onready var button_sound = $Container/Sound
@onready var button_label = $Container/NoteName
var button_color: Color
var is_hovered: bool = false

var color_value: Color
var color_hover: Color 

@export var current_sound: AudioStreamWAV
@export var current_color: Color

func _ready():
	#if current_color != Color.BLACK:
		#button_color.color = current_color
	if current_sound != null:
		button_sound.stream = current_sound
		#
	
	#print(current_sound.get_length() / 2)
	#await get_tree().create_timer(2).timeout
	#$Container/Color.color = Color.ANTIQUE_WHITE
	#color_value = button_color.color
	#color_hover = color_value.lightened(0.25)

func configure_button(audio: AudioStreamWAV, fill_color: Color, text: String):
	$Container/Sound.stream = audio
	$Container/Color.color = fill_color
	$Container/NoteName.text = text
	button_color = fill_color
	color_hover = fill_color.lightened(0.5)
	
	# Material shit (not needed for now)
	var shader: Shader = $Container/BGNoise.material.shader
	var mat: ShaderMaterial = $Container/BGNoise.material
	mat.set_shader_parameter("color", fill_color)

func _on_button_button_up():
	button_sound.playing = true
	color_clicked.emit()

func _on_button_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Container/Color, "color", button_color.lightened(0.5), 0.25)

func _on_button_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Container/Color, "color", button_color, 0.25)
