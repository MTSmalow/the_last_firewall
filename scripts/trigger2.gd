extends Area2D

var triggered = false

var dialogs = [
	"Você: cade todo mundo?",
	"Você: nunca vi esse lugar vazio, e cade o resto das casas?",
	"Você: talvez aquele senhor no mercadinho saiba algo.",
]

var dialog_index = 0
var dialog_ui = null

func _ready():
	dialog_ui = get_tree().get_first_node_in_group("dialog")

func _on_body_entered(body):
	if body.is_in_group("player") and not triggered:
		triggered = true
		start_dialog()

func start_dialog():
	GameManager.current_dialog = dialogs
	GameManager.dialog_index = 0
	GameManager.in_dialog = true

	dialog_ui.show_dialog(dialogs[0])
		
