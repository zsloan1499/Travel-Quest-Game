extends Node2D

var chest_area = false
var chest_x = 195
var chest_y = 63

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_scene = "level_8"
	Global.previous_scene = "level_6"
	if Global.chest_chest_open and Global.chest == true:
		$box.play("end")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("interact"):
		if chest_area == true:
			if Global.chest_chest_open == false or Global.chest == false:
				$box.play("end")
				Global.chest_chest_open = true
				$chest.global_position = Vector2(chest_x, chest_y)
				$chest.visible = true


func _on_box_area_body_entered(body):
	chest_area = true


func _on_box_area_body_exited(body):
	chest_area = false


func _on_chest_pickup_body_entered(body):
	Global.update_chest()
	$chest.visible = false
	$chest.global_position = Vector2(1000, 1000)
	$Label.visible = true
	$Goblin.global_position = Vector2(380, 118)
	$Goblin2.global_position = Vector2(116, 214)
	$Goblin3.global_position = Vector2(125, 263)
	$Goblin4.global_position = Vector2(297, 212)
	$Goblin5.global_position = Vector2(240, 266)
	$Goblin6.global_position = Vector2(58, 81)
	$Goblin7.global_position = Vector2(196, 268)
	await get_tree().create_timer(2).timeout
	$Label.visible = false



func _on_level_6_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_6.tscn"
		call_deferred("_change_scene", next_level_path)
		
func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
