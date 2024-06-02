extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
