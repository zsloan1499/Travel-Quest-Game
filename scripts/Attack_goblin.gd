class_name Attack_goblin
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func activate_top():
	visible = true
	await get_tree().create_timer(0.7).timeout
	if Global.goblin_attacking:
		$Detector_Up.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Detector_Up.disabled = true
		activate_top2()
	
func activate_bottom():
	visible = true
	await get_tree().create_timer(0.7).timeout
	if Global.goblin_attacking:
		$Detector_Down.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Detector_Down.disabled = true
		activate_bottom2()

func activate_left():
	visible = true
	await get_tree().create_timer(0.7).timeout
	if Global.goblin_attacking:
		$Detector_Left.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Detector_Left.disabled = true
		activate_left2()

func activate_right():
	visible = true
	await get_tree().create_timer(0.7).timeout
	if Global.goblin_attacking:
		$Detector_Right.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Detector_Right.disabled = true
		activate_right2()
		
func activate_top2():
	visible = true
	await get_tree().create_timer(1).timeout
	if Global.goblin_attacking:
		$Detector_Up.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Detector_Up.disabled = true
		activate_top2()
	
func activate_bottom2():
	visible = true
	await get_tree().create_timer(1).timeout
	if Global.goblin_attacking:
		$Detector_Down.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Detector_Down.disabled = true
		activate_bottom2()

func activate_left2():
	visible = true
	await get_tree().create_timer(1).timeout
	if Global.goblin_attacking:
		$Detector_Left.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Detector_Left.disabled = true
		activate_left2()

func activate_right2():
	visible = true
	await get_tree().create_timer(1).timeout
	if Global.goblin_attacking:
		$Detector_Right.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Detector_Right.disabled = true
		activate_right2()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage()
		



