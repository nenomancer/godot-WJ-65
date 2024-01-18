extends MarginContainer
signal color_clicked(button: MarginContainer)
signal button_enabled(enabled: bool)

#@onready var button = $Container/Color.color
@onready var button_sound = $Container/Sound
@onready var button_label = $Container/NoteName
@onready var original_scale = scale
var button_color: Color
var is_hovered: bool = false

var color_value: Color
var color_hover: Color 

@export var FLIP_TIME: float = 0.5

@export var current_sound: AudioStreamWAV
@export var current_color: Color
var flip_timer: float = 0.0

var state = states.is_hidden : set = set_state

enum states {
	is_hidden,
	is_flipping,
	is_flipped,
	is_playing,
	is_correct,
	is_incorrect,
}

func _ready():
	#if current_color != Color.BLACK:
		#button_color.color = current_color
	#state.set
	if current_sound != null:
		button_sound.stream = current_sound

func _physics_process(delta):
	match state:
		states.is_hidden:
			$Container/Backface.visible = true
			$Container/Button.disabled = true
			pass
		states.is_flipping:
			if flip_timer <= 1.0:
				scale.x = original_scale.x * abs((2 * flip_timer) - 1)
				if $Container/Backface.visible:
					if flip_timer >= 0.5:
						$Container/Backface.visible = false
				flip_timer += delta / float(FLIP_TIME)
			else:
				flip_timer = 0.0
				$Container/Button.disabled = false
				state = states.is_flipped
		states.is_flipped:
			$Container/Backface.visible = false
			pass
		states.is_playing:
			pass
	
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
	#if (state != is_flipped):
		#state = is_flipping;
		#
	color_clicked.emit()

func _on_button_mouse_entered():
	if $Container/Button.disabled == false:
		var tween = get_tree().create_tween()
		tween.tween_property($Container/Color, "color", button_color.lightened(0.5), 0.25)

func _on_button_mouse_exited():
	if $Container/Button.disabled == false:
		var tween = get_tree().create_tween()
		tween.tween_property($Container/Color, "color", button_color, 0.25)

func flip_button():
	pass

func _on_main_container_enabledd_buttons(enabled):
	if enabled:
		enabled = true
	else:
		enabled = false

func set_state(new_state):
	state = states.values()[new_state]
	#print(states[states[new_state]])
