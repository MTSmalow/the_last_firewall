extends CharacterBody2D

var max_life := 100
var life := 100
var direction : Vector2 = Vector2(0, 1)
var speed := 200
var is_attacking := false
var is_hurt := false
var knockback_force := 400
var knockback_velocity := Vector2()

var life_bar = null
@onready var anim = $AnimatedSprite2D

func read_input():
	if is_attacking:
		velocity = Vector2()
		return
	
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

func handle_attack():
	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		
		if direction == Vector2(0, -1):
			anim.play("attack_up")
		elif direction == Vector2(0, 1):
			anim.play("attack_down")
		elif direction == Vector2(-1, 0):
			anim.play("attack_left")
		elif direction == Vector2(1, 0):
			anim.play("attack_right")

func update_animation():
	if is_attacking:
		return
	
	if velocity.length() == 0:
		if direction == Vector2(0, -1):
			anim.play("idle_up")
		elif direction == Vector2(0, 1):
			anim.play("idle_down")
		elif direction == Vector2(-1, 0):
			anim.play("idle_left")
		elif direction == Vector2(1, 0):
			anim.play("idle_right")
	else:
		if direction == Vector2(0, -1):
			anim.play("walk_up")
		elif direction == Vector2(0, 1):
			anim.play("walk_down")
		elif direction == Vector2(-1, 0):
			anim.play("walk_left")
		elif direction == Vector2(1, 0):
			anim.play("walk_right")

func _physics_process(delta):
	collision_mask = 1 | 2
	
	if GameManager.in_dialog:
		velocity = Vector2()
		move_and_slide()
		return
	
	if is_hurt:
		velocity = knockback_velocity
		
		# desaceleração suave (opcional, mas fica muito melhor)
		knockback_velocity = knockback_velocity.lerp(Vector2.ZERO, 6 * delta)
		
		if knockback_velocity.length() < 10:
			is_hurt = false
	else:
		handle_attack()
		read_input()
	
	update_animation()
	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	if anim.animation.begins_with("attack"):
		is_attacking = false
		
func hit_enemy(enemy):
	if is_attacking:
		enemy.take_damage()
		
func take_damage(amount, from_position = Vector2.ZERO):
	if is_hurt:
		return
	
	life -= amount
	life = clamp(life, 0, max_life)
	
	if life_bar:
		life_bar.value = life
	
	# knockback
	var dir = (global_position - from_position).normalized()
	knockback_velocity = dir * knockback_force
	
	is_hurt = true
	
	await get_tree().create_timer(0.2).timeout
	is_hurt = false
	
	if life <= 0:
		die()
func die():
	print("Player morreu")


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("enemy") and is_attacking:
		body.take_damage(global_position)
