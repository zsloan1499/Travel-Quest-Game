extends Node2D

var chest_area = false
var helmet_x = 304
var helmet_y = 63

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_scene = "level_9"
	Global.previous_scene = "level_6"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("interact"):
		if chest_area == true:
			if Global.helmet_chest_open == false or Global.helmet == false:
				$box.play("end")
				Global.chest_chest_open = true
				$Helmet.global_position = Vector2(helmet_x, helmet_y)
				$Helmet.visible = true


func _on_level_6_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_6.tscn"
		call_deferred("_change_scene", next_level_path)


func _on_box_area_body_entered(body):
	chest_area = true


func _on_box_area_body_exited(body):
	chest_area = false


func _on_helmet_pickup_body_entered(body):
	Global.update_helmet()
	$Helmet.visible = false
	$Helmet.global_position = Vector2(1000, 1000)
	$Label.visible = true
	await get_tree().create_timer(2).timeout
	$Label.visible = false

func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)

