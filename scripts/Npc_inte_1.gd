extends Node2D

@onready var anim = $AnimatedSprite2D
var dialog_ui = null
var player_in_range = false
var dialog_text = "Olá, aventureiro!"

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		show_dialog()

func show_dialog():
	if dialog_ui:
		dialog_ui.show_dialog(dialog_text)
	
func _ready():
	dialog_ui = get_tree().get_first_node_in_group("dialog")
	anim.play("default")
