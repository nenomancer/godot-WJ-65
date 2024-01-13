extends Node2D
const AudioData = preload("res://AudioData.gd")
const GRAND_PIANO_A_ = preload("res://audio/piano/grand_piano_a#.wav")
# Called when the node enters the scene tree for the first time.
const BUTTON = preload("res://Button.tscn")
func _ready():
	var new_button = BUTTON.instantiate()
	new_button.position = Vector2(250, 250)
	add_child(new_button)
	#$AudioStreamPlayer.stream = AudioData.GRAND_PIANO_A
	$AudioStreamPlayer.stream = AudioData.DATA[randi_range(0, AudioData.DATA.size() - 1)]
	$AudioStreamPlayer.playing = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
