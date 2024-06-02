extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_button_down():
	var next_level_path = "res://scenes/level_0.tscn"
	get_tree().change_scene_to_file(next_level_path)

