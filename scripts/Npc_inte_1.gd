extends Node2D

@onready var anim = $AnimatedSprite2D
var dialog_ui = null
var player_in_range = false
var dialog_index = 0
var is_talking = false
var dialogs = [
	"Alice: Good morning… good morning… good m— ERROR… good morning.",
	"You: what?",
	"Alice: Good morning… good morning… good m— ERROR… good morning.",
	"You: What the hell is this? what’s going on?",
	"You: I think I should go to the village, maybe someone there knows what’s happening."
]


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func start_dialog():
	if dialog_ui:
		GameManager.in_dialog = true
		is_talking = true
		dialog_index = 0
		dialog_ui.show_dialog(dialogs[dialog_index])

func next_dialog():
	dialog_index += 1
	
	if dialog_index < dialogs.size():
		dialog_ui.show_dialog(dialogs[dialog_index])
	else:
		end_dialog()

func end_dialog():
	is_talking = false
	dialog_index = 0
	GameManager.in_dialog = false
	dialog_ui.panel.visible = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if not is_talking:
			start_dialog()
		else:
			next_dialog()

func show_dialog():
	if dialog_ui:
		dialog_ui.show_dialog(dialogs)
	
func _ready():
	dialog_ui = get_tree().get_first_node_in_group("dialog")
	anim.play("default")
