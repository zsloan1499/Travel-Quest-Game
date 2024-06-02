extends CharacterBody2D
var speed = 50
var follow_player = false
var player = null
var goblin_health = 4
var player_attack_direction: String
var is_alive = true
var attacking = false
var direction: String
var in_attack_area = false
@export var melee_attack:PackedScene = preload("res://scenes/melee_attack_goblin.tscn")
var melee:Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	melee = melee_attack.instantiate()
	add_child(melee)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	move(delta)
	
	
func move(delta):
	if follow_player == true and player.is_alive and is_alive and Global.goblin_attacking == false and in_attack_area == false:
		Global.goblin_attacking = false
	# Calculate the direction vector from enemy to player
		var direction = (player.position - position).normalized()
		 
		# Determine the animation and flipping direction based on the direction vector
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true  
		elif direction.x > 0:
			$AnimatedSprite2D.flip_h = false
			
	# Move the enemy towards the player at a constant speed
		position += direction * speed * delta
		$AnimatedSprite2D.play("walk")
		move_and_collide(Vector2(0,0))
	
func _on_vision_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		follow_player = true
		

func _on_attack_area_body_entered(body):
	if body.is_in_group("player") and is_alive:
		Global.goblin_attacking = true
		in_attack_area = true
		var player_position = body.global_position
		var goblin_position = global_position
		var player_relative_position = player_position - goblin_position
		if abs(player_relative_position.y) > abs(player_relative_position.x): # Player is closer vertically
			if player_relative_position.y < 0: # Player is above the goblin
				melee.activate_top()
				$AnimatedSprite2D.play("attack_back")
				await get_tree().create_timer(0.7).timeout
			else: # Player is below the goblin
				melee.activate_bottom()
				$AnimatedSprite2D.play("attack_front")
				await get_tree().create_timer(0.7).timeout
		else: # Player is closer horizontally
			if player_relative_position.x < 0: # Player is to the left of the goblin
				melee.activate_left()
				$AnimatedSprite2D.play("attack_side")
				await get_tree().create_timer(0.7).timeout
			else: # Player is to the right of the goblin
				melee.activate_right()
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("attack_side")
				await get_tree().create_timer(0.7).timeout
		


func _on_attack_area_body_exited(body):
	if body.is_in_group("player"):
		Global.goblin_attacking = false
		in_attack_area = false
		
func take_damage():
	if goblin_health > 1:
		goblin_health = goblin_health - Global.player_damage
		print(goblin_health)
		$hit.play()
		if goblin_health < 1:
			goblin_death()
	else:
		goblin_death()

func goblin_death():
	is_alive = false
	$death.play()
	self.queue_free()
	Quest.update_progress()
	Global.gold = Global.gold + 3
	
