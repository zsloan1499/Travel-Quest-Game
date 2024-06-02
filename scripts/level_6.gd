extends Node2D

#where they came from
var player_start_level3_x = 23
var player_start_level3_y = 129
var player_start_level7_x = 189
var player_start_level7_y = 273
var player_start_level8_x = 315
var player_start_level8_y = 26
var player_start_level9_x = 377
var player_start_level9_y = 117

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.current_scene == "level_3":
		$Player.global_position = Vector2(player_start_level3_x, player_start_level3_y)
		Global.current_scene = "level_6"
		Global.previous_scene = "level_3"
	elif Global.current_scene == "level_7":
		$Player.global_position = Vector2(player_start_level7_x, player_start_level7_y)
		Global.current_scene = "level_6"
		Global.previous_scene = "level_7"
	elif Global.current_scene == "level_8":
		$Player.global_position = Vector2(player_start_level8_x, player_start_level8_y)
		Global.current_scene = "level_6"
		Global.previous_scene = "level_8"
		print(Global.current_scene)
	elif Global.current_scene == "level_9":
		$Player.global_position = Vector2(player_start_level9_x, player_start_level9_y)
		Global.current_scene = "level_6"
		Global.previous_scene = "level_9"
		print(Global.current_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_3_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_3.tscn"
		call_deferred("_change_scene", next_level_path)


func _on_level_7_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_7.tscn"
		call_deferred("_change_scene", next_level_path)


func _on_level_8_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_8.tscn"
		call_deferred("_change_scene", next_level_path)


func _on_level_9_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_9.tscn"
		call_deferred("_change_scene", next_level_path)
		
func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
