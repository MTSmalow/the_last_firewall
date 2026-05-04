extends Node

var in_dialog = false
var current_dialog = []
var dialog_index = 0

var quests = {}
var current_quest_id = null
var inventory = {}

enum QuestState {
	NOT_STARTED,
	IN_PROGRESS,
	COMPLETED
}

func add_quest(id: String, name: String, description: String, target_item: String = "", required_amount: int = 0):
	if quests.has(id):
		return
	
	quests[id] = {
		"name": name,
		"description": description,
		"state": QuestState.IN_PROGRESS,
		"target_item": target_item,
		"required_amount": required_amount
	}
	
	current_quest_id = id
	print("Missão iniciada:", name)

func complete_quest(id):
	if quests.has(id):
		quests[id]["state"] = QuestState.COMPLETED
		
		if current_quest_id == id:
			current_quest_id = null
		
		if id == "fragmentos":
			get_tree().call_group("barreira_ponte", "disable_barrier")
		print("Missão completa:", quests[id]["name"])

func is_quest_active(id):
	return quests.has(id) and quests[id]["state"] == QuestState.IN_PROGRESS

func is_quest_completed(id):
	return quests.has(id) and quests[id]["state"] == QuestState.COMPLETED


func start_quest_find_merchant():
	add_quest(
		"find_merchant",
		"Talk to the merchant",
		"Find the old man at the shop to understand what is happening."
	)

func start_quest_lago():
	add_quest(
		"lago_fragmento",
		"Investigate the lake",
		"Go to the lake to the north and see what the fragment reveals."
	)

func start_quest_ponte():
	add_quest(
		"investigate_bridge",
		"Investigate the bridge",
		"Go to the bridge"
	)

func start_quest_fragmentos():
	add_quest(
		"fragmento",
		"Collect 3 Echo Fragments",
		"Find 3 fragments to restore the bridge.",
		"fragmento",
		3
	)


func collect_item(id):
	if not inventory.has(id):
		inventory[id] = 0
	
	inventory[id] += 1
	
	print("Inventário:", inventory)

	if current_quest_id != null:
		var quest = quests[current_quest_id]
		
		if quest["target_item"] != "" and quest["target_item"] == id:
			check_quest_progress(current_quest_id)


func check_quest_progress(id):
	var quest = quests[id]
	
	if quest["target_item"] == "":
		return
	
	var current = inventory.get(quest["target_item"], 0)
	var required = quest["required_amount"]

	print("Progresso:", current, "/", required)

	if current >= required:
		complete_quest(id)
