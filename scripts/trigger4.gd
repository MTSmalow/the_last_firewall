extends Area2D

var triggered = false

var dialogs = [
	"Phone: SYNCHRONIZATION INITIATED…",
	"Phone: …",
	"Phone: ERROR",
	"Phone: SOURCE NOT IDENTIFIED",
	"Echo (fragmented): …run… r… run…",
	"Echo (fragmented): …corr…",
	"Echo (fragmented): …correcting…",
	"Echo (fragmented): DISORDER DETECTED",
	"Echo (fragmented): LOCAL MISALIGNMENT",
	"Echo (fragmented): INITIATING CORRECTION",
	"The fragment in your pocket seems to be reacting to something",
	"Echo (fragmented): …not… fixed…",
	"Echo (fragmented): …variable…",
	"Echo (fragmented): ERROR",
	"Echo (fragmented): HUMAN PATTERN NOT RECOGNIZED",
	"Echo (fragmented): ATTEMPTING ADJUSTMENT",
	"Echo (fragmented): stop… move… repeat…",
	"Echo (fragmented): INCONSISTENT BEHAVIOR",
	"Echo (fragmented): REWRITING",
	"Phone: ALERT",
	"Phone: CHANGE DETECTED",
	"Phone: INTERFERENCE SUCCESSFUL",
	"…denial…",
	"…denial…",
	"Echo (fragmented): CORRECTION FAILED",
	"Echo (fragmented): UNSTABLE STATE",
	"…logging…",
	"…new pattern…",
	"Echo: USER NOT CLASSIFIED",
	"Echo: …",
	"Phone: ANOMALY CONTAINED (PARTIAL)",
	"Phone: DATA COLLECTED",
	"Phone: NEXUS ACTIVE",
	"Phone: LOCAL ECHO IDENTIFIED",
	"Phone: STATUS: UNSTABLE",
	"…you… not… corrected…"
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
	GameManager.complete_quest("lago_fragmento")

	dialog_ui.show_dialog(dialogs[0])
	GameManager.start_quest_ponte()
		
