extends Node

@onready var player = $Player/CharacterBody2D
@onready var life_bar = $HP/ProgressBar
@onready var dialog_ui = $DialogUI	

var dialogs = [
	"You: ...",
	"UNSTABLE SIGNAL DETECTED",
	"You: what is this?",
	"You: better ask someone."
]

func _ready():
	player.life_bar = life_bar
	start_intro_dialog()
	
func start_intro_dialog():
	GameManager.current_dialog = dialogs
	GameManager.dialog_index = 0
	GameManager.in_dialog = true

	dialog_ui.show_dialog(GameManager.current_dialog[0])
	
func _process(delta):
	if GameManager.in_dialog and Input.is_action_just_pressed("interact"):
		next_dialog()
		
func next_dialog():
	GameManager.dialog_index += 1
	
	if GameManager.dialog_index < GameManager.current_dialog.size():
		dialog_ui.show_dialog(GameManager.current_dialog[GameManager.dialog_index])
	else:
		end_dialog()
		
func end_dialog():
	GameManager.in_dialog = false
	dialog_ui.panel.visible = false
