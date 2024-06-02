extends CharacterBody2D
var speed = 55
var follow_player: bool
var player = null
var slime_health = 3
var player_attack_direction: String
var is_alive = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	player = $'../Player'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	#if slime_health <= 0:
		#slime_death()
		
	if follow_player and player.is_alive and is_alive:
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

		


#When player gets close enough to slime for it to follow it endlessly
func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		player = body
		follow_player = true




func take_damage():
	if slime_health > 1:
		print("slime damage call")
		slime_health = slime_health - Global.player_damage
		print(slime_health)
		$hit.play()
		if slime_health < 1:
			slime_death()
	else:
		slime_death()

func slime_death():
	is_alive = false
	$AnimatedSprite2D.play("death")
	$hit.play()
	Global.gold = Global.gold + 1
	Quest.update_progress()
	await get_tree().create_timer(0.5).timeout
	self.queue_free()
