extends Area2D

var triggered = false

var dialogs = [
	"nao completa"
]

var dialog_index = 0
var dialog_ui = null

func _ready():
	dialog_ui = get_tree().get_first_node_in_group("dialog")

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	if GameManager.is_quest_completed("ponte"):
		return

	if not GameManager.quests.has("ponte"):
		GameManager.start_quest_ponte()
		triggered = true
		start_dialog()
		return

	if GameManager.is_quest_active("ponte"):
		print("Missão da ponte já está em andamento")
		start_dialog()

func start_dialog():
	GameManager.current_dialog = dialogs
	GameManager.dialog_index = 0
	GameManager.in_dialog = true

	dialog_ui.show_dialog(dialogs[0])
		
