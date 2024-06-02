extends Node2D


var player_position = Vector2.ZERO
var player_startx = 45
var player_starty = 93
var player_enter_startx = 373
var player_enter_starty = 104
var transition_scene = false
var current_scene = "level_1"
var player: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.first_load == true:
		$Player.global_position = Vector2(player_startx, player_starty)
		print("first load")
		Global.first_load = false
		Global.current_scene = "level_1"
	else: 
		$Player.global_position = Vector2(player_enter_startx, player_enter_starty)
		Global.current_scene = "level_1"
		

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_2_tranisiton_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_2.tscn"
		call_deferred("_change_scene", next_level_path)
		#get_tree().call_deffered()
		
func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)



