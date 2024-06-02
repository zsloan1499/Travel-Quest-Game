class_name Attack
extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func activate_top():
	visible = true
	$Detector_Up.disabled = false
	await get_tree().create_timer(0.75).timeout
	$Detector_Up.disabled = true
	
func activate_bottom():
	visible = true
	$Detector_Down.disabled = false
	await get_tree().create_timer(0.75).timeout
	$Detector_Down.disabled = true

func activate_left():
	visible = true
	$Detector_Left.disabled = false
	await get_tree().create_timer(0.75).timeout
	$Detector_Left.disabled = true

func activate_right():
	visible = true
	$Detector_Right.disabled = false
	await get_tree().create_timer(0.75).timeout
	$Detector_Right.disabled = true

func _on_body_entered(body):
	if body.is_in_group("slime"):
		body.take_damage()
	if body.is_in_group("goblin"):
		body.take_damage()

		



