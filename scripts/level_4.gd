extends Node2D
var player_start_level2_x = 205
var player_start_level2_y = 244
var player_start_level5_x = 200
var player_start_level5_y = 35


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.current_scene == "level_2":
		$Player.global_position = Vector2(player_start_level2_x, player_start_level2_y)
		Global.current_scene = "level_4"
		Global.previous_scene = "level_2"
	elif Global.current_scene == "level_5":
		$Player.global_position = Vector2(player_start_level5_x, player_start_level5_y)
		Global.current_scene = "level_4"
		Global.previous_scene = "level_5"
		print(Global.current_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_2_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_2.tscn"
		call_deferred("_change_scene", next_level_path)




func _on_level_6_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_5.tscn"
		call_deferred("_change_scene", next_level_path)
		
func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
