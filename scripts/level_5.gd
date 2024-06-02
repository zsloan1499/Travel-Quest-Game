extends Node2D

var player_start_level4_x = 313
var player_start_level4_y = 24
var boots_x = 55
var boots_y = 51
var chest_area = false


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_scene = "level_5"
	Global.previous_scene = "level_4"
	if Global.boots_chest_open and Global.boots == true:
		$chest.play("end")
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("interact"):
		if chest_area == true:
			if Global.boots_chest_open == false or Global.boots == false:
				$chest.play("end")
				Global.boots_chest_open = true
				$Boots.global_position = Vector2(boots_x, boots_y)
				$Boots.visible = true



func _on_area_2d_body_entered(body):
	chest_area = true


func _on_area_2d_body_exited(body):
	chest_area = false

func _on_chest_animation_finished(default):
	$chest.play("end")


func _on_boot_pickup_body_entered(body):
	Global.update_boots()
	$Boots.visible = false
	$Boots.global_position = Vector2(1000, 1000)
	$Label.visible = true
	await get_tree().create_timer(2).timeout
	$Label.visible = false



func _on_level_4_transitiion_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_4.tscn"
		call_deferred("_change_scene", next_level_path)
		
func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
