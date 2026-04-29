extends CharacterBody2D

var speed := 100
var life := 3
var player = null

var player_in_area = false
var damage_cooldown = 1.0
var can_attack = true
var is_dead = false
var is_hurt = false
var knockback_force := 300
var knockback_velocity := Vector2()

@onready var anim = $AnimatedSprite2D

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player == null or is_dead:
		return
	
	if is_hurt:
		velocity = knockback_velocity
	else:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	
	move_and_slide()
	
	if not is_hurt:
		update_animation(velocity.normalized())
	
	handle_attack()

func update_animation(dir):
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			anim.play("walk_right")
		else:
			anim.play("walk_left")
	else:
		if dir.y > 0:
			anim.play("walk_down")
		else:
			anim.play("walk_up")

func handle_attack():
	if player_in_area and can_attack:
		can_attack = false
		
		player.take_damage(10, global_position)
		
		await get_tree().create_timer(damage_cooldown).timeout
		can_attack = true

func take_damage(from_position):
	if is_dead or is_hurt:
		return
	
	life -= 1
	print("Inimigo levou dano! Vida:", life)
	
	# DIREÇÃO CONTRÁRIA AO ATAQUE
	var dir = (global_position - from_position).normalized()
	knockback_velocity = dir * knockback_force
	
	is_hurt = true
	
	# tempo de knockback
	await get_tree().create_timer(0.2).timeout
	is_hurt = false
	
	# cooldown de dano
	await get_tree().create_timer(0.5).timeout
	
	if life <= 0:
		die()

func die():
	queue_free()

# Detecta quando o player entra na área de ataque
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true

# Detecta quando o player sai da área
func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
