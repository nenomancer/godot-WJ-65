extends Container
# Called when the node enters the scene tree for the first time.
const BUTTON = preload("res://button.tscn")
const audio_data = preload("res://Assets/audio_data.gd")
const color_data = preload("res://Assets/color_data.gd")

@onready var background_correct = $"../BackgroundCorrect"
@onready var points_label = $"../Points"
var points: int = 0
var stages: int = 3
var stage_index: int = 0

#const colors = [green, jade, turquoise, baby_blue, blue, purple, pink, salmon]
var colors: Array = color_data.DATA
const sounds: Dictionary = audio_data.DATA
# VALJDA KJE TREBA ARRAY OD VEKJE GENERIRANI KOOPCHINAJ
var loaded_buttons: Array
var generated_buttons: Array

var index = 0
var sound_color_pairs = {
	# note: String,
	# sound: AudioStreamWAV,
	# color: Color
}

var correct_index: int
var correct_color: Color
var correct_sound: AudioStreamWAV

func _ready():
	generate_color_pairs(12, 1)
	print(sound_color_pairs.keys())
	update_points()
	
	loaded_buttons = $Colors.get_children()
	if loaded_buttons.size() > 0:
		load_buttons()	
		
	# Use to randomly generate buttons
	#generate_buttons(3)
	#var i = 0
	refresh_scene()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func refresh_scene():
	if stage_index < stages:
		for child in $Colors.get_children():
			$Colors.remove_child(child)
		generate_buttons(3)
		stage_index += 1
	else:
		print("NO MORE STAGES WTF")
	
		#show_question()
		
func update_points(point_amount: int = 0):
	points += point_amount
	points_label.text = "Points: " + str(points)

func set_correct_answer(button: MarginContainer):
	correct_color = button.get_node("Color").color
	correct_sound = button.get_node("Sound").stream
	$CorrectNote.text = "Correct note: " + button.get_node("NoteName").text

func load_buttons():
	correct_index = randi_range(0, loaded_buttons.size() - 1)
	
	for button in loaded_buttons:
		var target_sound = button.get_node("Sound").stream
		button.color_clicked.connect(Callable(check_answer.bind(button)))
		
		for key in sound_color_pairs:
			var audition_sound = sound_color_pairs[key].sound
			if(audition_sound == target_sound):
				var text_color = Color.BLACK
				var new_color = sound_color_pairs[key].color
				var new_text = key
				button.color_hover = new_color.lightened(0.5)
				var sound = button.get_node("Sound").stream
				
				button.configure_button(sound, new_color, new_text, text_color)
				#button.get_node("Color").color = new_color
				#button.get_node("NoteName").text = new_text
				#button.color_value = new_color
				
		if correct_index == button.get_index():
			set_correct_answer(button)

func generate_buttons(number_of_buttons: int):
	var i = 0
	correct_index = randi_range(0, number_of_buttons - 1)
	print("CORRECT INDEX: ", correct_index)
	
	while i < number_of_buttons:
		# 0
		# sound_color_pairs[0]
		var indexx = randi_range(0, sound_color_pairs.values().size() - 1)
		
		var new_button = BUTTON.instantiate()
		
		var text_color: Color = Color.BLACK
		var new_color: Color = sound_color_pairs.values()[indexx].color
		var new_sound: AudioStreamWAV = sound_color_pairs.values()[indexx].sound
		var new_label: String = sound_color_pairs.values()[indexx].note
		
		new_button.color_value = new_color
		new_button.color_hover = new_color.lightened(0.5)
		new_button.color_clicked.connect(Callable(check_answer).bind(new_button))
		
		new_button.configure_button(new_sound, new_color, new_label, text_color)
		
		if correct_index == i: 
			set_correct_answer(new_button)
		
		#var luminance = sound_color_pairs[indexx].color.get_luminance()
		#if luminance <= 0.5:
			#text_color = Color.WHITE
		
		#sound_color_pairs.erase(sound_color_pairs.keys()[indexx])
		$Colors.add_child(new_button)
		i += 1

func check_answer(button):
	print('Button: ', button, ', correct sound: ', correct_sound, ', button sound: ', button.get_node("Sound").stream)
	if correct_sound == button.get_node("Sound").stream:
		print("You guessed the CORRECT color")
		background_correct.visible = true
		update_points(10)
		refresh_scene()
	else:
		print("You guessed the WRONG color")
		background_correct.visible = false
		update_points(-5)
	
func generate_color_pairs(note_range: int = 3, semitone_skip: int = 4):
	var index = 0
	for i in note_range:
		sound_color_pairs[sounds.keys()[index]] = {
			note = sounds.keys()[index],
			sound = sounds.values()[index],
			color = colors[index],
		}
		index = (index + semitone_skip) % sounds.size() # Every OTHER note (in this case: C, E, G)

func mix_color(colors: Array[Color]) -> Color:
	# Mix two or more Colors
	var new_color: Color
	var color_sum: Color
	
	for color in colors:
		color_sum += color
	return color_sum / colors.size()
	

