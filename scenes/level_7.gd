extends Node2D



var in_boots_area = false
var in_chest_area = false
var in_helmet_area = false

var dialogue_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$NPC.play("default")
	if Global.current_scene == "level_6":
		Global.current_scene = "level_7"
		Global.previous_scene = "level_6"
	elif Global.current_scene == "level_10":
		Global.current_scene = "level_7"
		Global.previous_scene = "level_10"
	elif Global.current_scene == "level_11":
		Global.current_scene = "level_7"
		Global.previous_scene = "level_11"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	upgrade_boots()
	upgrade_chest()
	upgrade_helmet()

func _on_level_6_transition_body_entered(body):
	if body.is_in_group("player"):
		var next_level_path = "res://scenes/level_6.tscn"
		call_deferred("_change_scene", next_level_path)
		
func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)


func upgrade_boots():
	if Input.is_action_just_pressed("interact") and in_boots_area == true and Global.metal_fragments > 3 and Global.boots == true:
		Global.metal_fragments = Global.metal_fragments - 3
		Global.upgraded_boots = true
		Global.update_boots()
	

	
func upgrade_chest():
	if Input.is_action_just_pressed("interact") and in_chest_area == true and Global.metal_fragments > 3 and Global.chest == true:
		Global.metal_fragments = Global.metal_fragments - 5
		Global.upgraded_chest = true
		Global.update_chest()
	

func upgrade_helmet():
	if Input.is_action_just_pressed("interact") and in_helmet_area == true and Global.metal_fragments > 3 and Global.helmet == true:
		Global.metal_fragments = Global.metal_fragments - 4
		Global.upgraded_helmet = true
		Global.update_helmet()

func _on_boot_upgarde_area_body_entered(body):
	in_boots_area = true


func _on_boot_upgarde_area_body_exited(body):
	in_boots_area = false


func _on_chest_upgarde_area_body_entered(body):
	in_chest_area = true


func _on_chest_upgarde_area_body_exited(body):
	in_chest_area = false


func _on_helmet_upgarde_area_body_entered(body):
	in_helmet_area = true
	


func _on_helmet_upgarde_area_body_exited(body):
	in_helmet_area = false
	
