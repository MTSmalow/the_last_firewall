extends CharacterBody2D

var direction : Vector2 = Vector2(0, 1) # começa olhando pra baixo
var speed := 200

@onready var anim = $AnimatedSprite2D

func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
	elif Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0, 1)
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
	elif Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1, 0)

	velocity = velocity.normalized() * speed

func update_animation():
	if velocity.length() == 0:
		# PARADO (idle)
		if direction == Vector2(0, -1):
			anim.play("idle_up")
		elif direction == Vector2(0, 1):
			anim.play("idle_down")
		elif direction == Vector2(-1, 0):
			anim.play("idle_left")
		elif direction == Vector2(1, 0):
			anim.play("idle_right")
	else:
		# ANDANDO (walk)
		if direction == Vector2(0, -1):
			anim.play("walk_up")
		elif direction == Vector2(0, 1):
			anim.play("walk_down")
		elif direction == Vector2(-1, 0):
			anim.play("walk_left")
		elif direction == Vector2(1, 0):
			anim.play("walk_right")

func _physics_process(delta):
	read_input()
	update_animation()
	move_and_slide()
