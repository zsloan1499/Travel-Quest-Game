extends Node2D

var player_start_level2_x = 41
var player_start_level2_y = 165
var player_start_level6_x = 380
var player_start_level6_y = 176
var player_start_level_x = 41
var player_start_level_y = 165



# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.current_scene == "level_2":
		$Player.global_position = Vector2(player_start_level2_x, player_start_level2_y)
		Global.previous_scene = "level_2"
		Global.current_scene = "level_3"
	if Global.current_scene == "level_6":
		$Player.global_position = Vector2(player_start_level6_x, player_start_level6_y)
		Global.previous_scene = "level_6"
		Global.current_scene = "level_3"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_2_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_2.tscn"
		call_deferred("_change_scene", next_level_path)
		
		



func _on_level_5_tranisition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_6.tscn"
		call_deferred("_change_scene", next_level_path)

func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)

