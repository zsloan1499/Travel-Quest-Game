extends CharacterBody2D

const speed = 50
var direction: String
 
func _physics_process(delta):
	move(delta)
	

func _ready():
	$AnimatedSprite2D.play("idle")

func move(delta):
	velocity.x = speed
	velocity.y = 0
	direction = "right"
	animation_player(1)
	move_and_slide()
	
func animation_player(move):
	var direct = direction
	var flip = true
	if direct == "right":
		$AnimatedSprite2D.flip_h = false
		if move == 1 :
			$AnimatedSprite2D.play("side_walk")
		elif move == 0 :
			$AnimatedSprite2D.play("side_idle")
			
	if direct == "left":
		$AnimatedSprite2D.flip_h = true
		if move == 1 :
			$AnimatedSprite2D.play("side_walk")
		elif move == 0 :
			$AnimatedSprite2D.play("side_idle")
			
	if direct == "down":
		if move == 1 :
			$AnimatedSprite2D.play("walk")
		elif move == 0 :
			$AnimatedSprite2D.play("idle")
			
	if direct == "up":
		if move == 1 :
			$AnimatedSprite2D.play("away_walk")
		elif move == 0 :
			$AnimatedSprite2D.play("back_idle")




