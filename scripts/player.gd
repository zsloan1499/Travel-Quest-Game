extends CharacterBody2D

var speed = 100
var direction: String
var take_damage_timer: Node
var attacking = false
var is_alive = true
var in_quest_area = false
var in_shop_area = false
var pressed = false
var damage_reduction = 1
var canInteract = true

@export var melee_attack:PackedScene = preload("res://scenes/melee_attack.tscn")
var melee:Node
var quest_status = "Inactive"





func _process(delta):
	update_armor()
	update_health()
	potion()


func _ready():
	is_alive = true
	attacking = false
	$AnimatedSprite2D.play("idle")
	take_damage_timer = $take_damage_timer
	melee = melee_attack.instantiate()
	add_child(melee)
	
func _physics_process(delta):
	if is_alive == true:
		move(delta)
		quick_attack()
	
func move(delta):
	if in_quest_area == true:
		if Input.is_action_pressed("interact"):
			#print("quest pressed")
			Quest.give_quest()
	if Input.is_action_pressed("move_right") and attacking == false:
		velocity.x = speed
		velocity.y = 0
		direction = "right"
		animation_player(1)
		
	elif Input.is_action_pressed("move_left")and attacking == false:
		velocity.x = -speed
		velocity.y = 0
		direction = "left"
		animation_player(1)
		
	elif Input.is_action_pressed("move_down")and attacking == false:
		velocity.x = 0
		velocity.y = speed
		direction = "down"
		animation_player(1)
		
	elif Input.is_action_pressed("move_up") and attacking == false:
		velocity.x = 0
		velocity.y = -speed
		direction = "up"
		animation_player(1)
		
	else:
		animation_player(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func animation_player(move):
	var direct = direction
	var flip = true
	if direct == "right":
		$AnimatedSprite2D.flip_h = false
		if move == 1 :
			$AnimatedSprite2D.play("side_walk")
		elif move == 0 :
			if attacking == false:
				$AnimatedSprite2D.play("side_idle")
				
	if direct == "left":
		$AnimatedSprite2D.flip_h = true
		if move == 1 :
			$AnimatedSprite2D.play("side_walk")
		elif move == 0 :
			if attacking == false:
				$AnimatedSprite2D.play("side_idle")
			
	if direct == "down":
		if move == 1 :
			$AnimatedSprite2D.play("walk")
		elif move == 0 :
			if attacking == false:
				$AnimatedSprite2D.play("idle")
			
	if direct == "up":
		if move == 1 :
			$AnimatedSprite2D.play("away_walk")
		elif move == 0 :
			if attacking == false:
				$AnimatedSprite2D.play("back_idle")

#Slime enters area, start damage timer right below
func _on_hit_box_body_entered(body):
	if body.is_in_group("slime"):
			take_damage_timer.start()
			print("timer start")

#when a slime is in collisiona rea, deal damage if they have been there long enough
func _on_timer_timeout():
	if Global.health >= 1:
		Global.health = Global.health - (15 * damage_reduction)
		$HealthBar.value = Global.health
		$hit.play()
	else:
		die()
		
func update_health():
	if Global.health == 100:
		$HealthBar.visible = false
	else:
		$HealthBar.visible = true
	$HealthBar.value = Global.health
	
func update_armor():
	if Global.chest == true:
		damage_reduction = 0.75
	elif Global.upgraded_chest == true:
		damage_reduction = 0.50
	else:
		damage_reduction = 1
		
		
	if Global.boots == true:
		speed = 120
	elif Global.upgraded_boots == true:
		speed = 140
	else:
		speed = 100
	
func potion():
	if Input.is_action_pressed("potion"):
		if Global.potion >= 1 and Global.health < 100 and canInteract == true:
			$shop_timer.start()
			canInteract = false
			Global.potion = Global.potion - 1
			Global.health = Global.health + 25
			if Global.health > 100:
				Global.health = 100
	if in_shop_area == true:
		if Input.is_action_pressed("interact") and canInteract == true:
			#TODO add timer so it can only press once
			if Global.gold >= 5:
				$shop_timer.start()
				canInteract = false
				Global.gold = Global.gold - 5
				Global.potion = Global.potion + 1
	
#slime leaves area, stop damage timer
func _on_hit_box_body_exited(body):
	if body.is_in_group("slime"):
		take_damage_timer.stop()


func die():
	is_alive = false
	$AnimatedSprite2D.play("death")
	#$death.play()
	await get_tree().create_timer(0.5).timeout
	var next_level_path = "res://scenes/death_scene.tscn"
	get_tree().change_scene_to_file(next_level_path)
	Global.reset()
	Quest.reset()
	
	
	#TODO add a death scene
	#TODO maybe make the like whole screen black and zoom in on player once they die
	#TODO once dead, game over
	#implement two different timers not await timers, one for animation and one for collision boxe

func quick_attack():
	if Input.is_action_just_pressed("base_attack"):
		attacking = true
		if direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			melee.activate_right()
			$swing.play()
			await get_tree().create_timer(0.4).timeout
			attacking = false
			
		if direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			melee.activate_left()
			$swing.play()
			await get_tree().create_timer(0.4).timeout
			attacking = false
			
		if direction == "up":
			$AnimatedSprite2D.play("behind_attack")
			melee.activate_top()
			$swing.play()
			await get_tree().create_timer(0.4).timeout
			attacking = false
			
		if direction == "down":
			$AnimatedSprite2D.play("attack")
			melee.activate_bottom()
			$swing.play()
			await get_tree().create_timer(0.4).timeout
			attacking = false

func take_damage():
	if Global.health > 0:
		Global.health = Global.health - (30 * damage_reduction) 
		$hit.play()
		if Global.health < 1:
			die()
		print(Global.health)
	else:
		die()
			

func _on_level_2_quest_emit_on():
	in_quest_area = true
	if Quest.status == Quest.QuestStatus.COMPLETED:
		Quest.status = Quest.QuestStatus.INACTIVE



func _on_level_2_quest_emit_off():
	in_quest_area = false


func _on_level_2_shop_emit_on():
	in_shop_area = true


func _on_level_2_shop_emit_off():
	in_shop_area = false



func _on_shop_timer_timeout():
	canInteract = true
