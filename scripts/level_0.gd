extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.first_load = true
	Global.health = 100
	Global.boots = false
	Global.upgraded_boots = false
	Global.helmet = false
	Global.upgraded_helmet = false
	Global.chest = false
	Global.upgraded_chest = false
	play_audio_loop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	$Player.global_position = Vector2(-75, 76)


func _on_play_button_down():
	var next_level_path = "res://scenes/level_1.tscn"
	get_tree().change_scene_to_file(next_level_path)


func _on_credits_button_down():
	var next_level_path = "res://scenes/credits.tscn"
	get_tree().change_scene_to_file(next_level_path)
	print("credits")
	
func play_audio_loop():
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.play()

#has a signal so when the audio finishes it will continue to play
func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()

