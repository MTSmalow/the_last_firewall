extends Node2D

@onready var anim = $AnimatedSprite2D
var dialog_ui = null
var player_in_range = false
var dialog_index = 0
var is_talking = false
var dialogs = [
	"Merchant: Hey… you don’t seem stuck.",
	"Merchant: You still respond… that’s good.",
	"Merchant: Tell me… did you also see things flickering?",
	"Merchant: Like… the world forgetting how it works?",
	"Merchant: I started keeping some strange things that appeared around here.",
	"Merchant: They’re not normal items… they’re pieces of signal.",
	"Merchant: I call them fragments.",
	"Merchant: They keep vibrating… as if they’re trying to return somewhere.",
	"Merchant: The funny thing is that…",
	"Merchant: when I get close to certain points on the map… they react.",
	"Merchant: There’s a place up north… near that small lake.",
	"Merchant: The water doesn’t reflect properly. Have you noticed?",
	"Merchant: I don’t go near there.",
	"Merchant: Things… start repeating.",
	"Merchant: If you go there… take a fragment with you.",
	"Merchant: Maybe it will “respond” to whatever is there.",
	"Merchant: And if something starts talking to you…",
	"Merchant: don’t answer too quickly.",
	"Merchant: Sometimes… it’s not meant for us to understand.",
	"[You received a fragment]",
	"Merchant: …so you felt it, right?",
	"Merchant: Did the fragment get heavier?",
	"Merchant: Or… more 'present'?",
	"Merchant: That means you were noticed.",
	"Merchant: The lake isn’t just water.",
	"Merchant: That thing there is like… a broken point.",
	"Merchant: Something is trying to fix that place.",
	"Merchant: But it’s not doing it right.",
	"Merchant: If the fragment reacts there…",
	"Merchant: you’ll see.",
	"Merchant: Just don’t let it “synchronize” too much with you.",
	"Merchant: I’ve seen people stop talking after that.",
	"Merchant: Go on… but come back whole.",
]


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func start_dialog():
	GameManager.complete_quest("find_merchant")
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
	
	GameManager.collect_item("fragmento")
	GameManager.start_quest_lago()

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
