extends Node2D

var player_position = Vector2.ZERO
var player_start_level1_x = 46
var player_start_level1_y = 154
var player_start_level3_x = 377
var player_start_level3_y = 154
var player_start_level4_x = 313
var player_start_level4_y = 24
var player: Node
var inside = false
var inside_quest = false
var inside_shop_keep = false

signal quest_emit_on
signal quest_emit_off
signal shop_emit_on
signal shop_emit_off

# Called when the node enters the scene tree for the first time.
func _ready():
	inside_quest = false
	player_start_position()





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_start_position():
	if Global.current_scene == "level_1":
		$Player.global_position = Vector2(player_start_level1_x, player_start_level1_y)
		Global.previous_scene = "level_1"
		Global.current_scene = "level_2"
	elif Global.current_scene == "level_3":
		$Player.global_position = Vector2(player_start_level3_x, player_start_level3_y)
		Global.previous_scene = "level_3"
		Global.current_scene = "level_2"
	elif Global.current_scene == "level_4":
		$Player.global_position = Vector2(player_start_level4_x, player_start_level4_y)
		Global.previous_scene = "level_4"
		Global.current_scene = "level_2"

func _on_level_1_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_1.tscn"
		call_deferred("_change_scene", next_level_path)



func _on_level_3_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_3.tscn"
		call_deferred("_change_scene", next_level_path)



func _on_level_4_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_4.tscn"
		call_deferred("_change_scene", next_level_path)
		
		
func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)



func _on_shop_enter_body_entered(body):
	if body.is_in_group("player"):
		if inside == false:
			inside = true
			$QuestGiverBox.visible = true
			$ShopKeepBox.visible = true
			$QuestGiverBox2.visible = false
			$ShopKeepBox2.visible = false
			$QuestGiverBox3.visible = false
			$QuestInteract.visible = false
			await get_tree().create_timer(2).timeout
			$QuestGiverBox.visible = false
			$ShopKeepBox.visible = false
		
		


func _on_shop_exit_body_entered(body):
	if body.is_in_group("player"):
		if inside == true:
			inside = false
			$QuestGiverBox.visible = false
			$ShopKeepBox.visible = false
			$QuestGiverBox2.visible = true
			$ShopKeepBox2.visible = true
			$QuestGiverBox3.visible = false
			$QuestInteract.visible = false
			await get_tree().create_timer(2).timeout
			$QuestGiverBox2.visible = false
			$ShopKeepBox2.visible = false

	


func _on_quest_area_body_entered(body):
	if body.is_in_group("player"):
		print("box entered")
		inside_quest = true
		$QuestGiverBox.visible = false
		$QuestGiverBox2.visible = false
		$QuestInteract.visible = true
		if inside_quest == true:
			$QuestGiverBox3.visible = true
			# Check if the quest is completed
		emit_signal("quest_emit_on")
	



func _on_quest_area_body_exited(body):
	if body.is_in_group("player"):
		inside_quest = false
		print("box left")
		emit_signal("quest_emit_off")
		if inside_quest == false:
			$QuestGiverBox3.visible = false
			$QuestInteract.visible = false


func _on_market_area_body_entered(body):
	if body.is_in_group("player"):
		print("box entered")
		inside_shop_keep = true
		$ShopInteract.visible = true
		$ShopKeepBox3.visible = true
		emit_signal("shop_emit_on")



func _on_market_area_body_exited(body):
	if body.is_in_group("player"):
		print("box entered")
		inside_shop_keep = false
		$ShopKeepBox3.visible = false
		$ShopInteract.visible = false
		emit_signal("shop_emit_off")
