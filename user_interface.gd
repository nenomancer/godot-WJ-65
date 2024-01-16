extends Control
#
#@onready var label = $Label
#@onready var button = $Button
#@onready var background = $Background
#@onready var noise_offset = $Background.texture.noise.offset
@onready var background = $Background

func _ready():
	pass
	#print(background.texture.noise.seed)
	#material = background.material.get_

func _physics_process(delta):
	#pass
	background.material.set_shader_parameter("noise_offset", get_global_mouse_position())
	background.material.set_shader_parameter("scroll_speed", get_global_mouse_position().y * 0.005)
	print('mouse position: ', get_global_mouse_position())	
	print('shader offset: ', background.material.get_shader_parameter("noise_offset"))
	
#func game_intro():
	#label.text = "This is the intro text"
	#var next_text = await skip_text()
	#if next_text: 
		#label.text = "This is the next text yay"
#
#func skip_text():
	#await button.button_up
	#return true
	
func _gui_input(event):
	pass
	background.material.set_shader_parameter("noise_offset", get_global_mouse_position())

##var offset_value = Vector3(get_local_mouse_position().x - 1.0, get_local_mouse_position().y - 1.0, 0) * 0.001
#var offset_y = get_local_mouse_position().y * 0.5
#var current_amplitude
#print(offset_y)
#background.texture.noise.domain_warp_amplitude = lerpf(background.texture.noise.domain_warp_amplitude, offset_y, .1)
##background.texture.noise.offset += offset_value
#print(background.texture.noise.domain_warp_frequency)

# MAYBE ADD SOUND EFFECTS FOR EVERYTHING
	 #background.material.set_shader_parameter("colors", [Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1)])
