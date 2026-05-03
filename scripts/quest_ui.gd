extends CanvasLayer

@onready var panel = $Panel
@onready var label = $Panel/Label

func _process(delta):
	update_quest_ui()

func update_quest_ui():
	for id in GameManager.quests:
		var quest = GameManager.quests[id]
		
		if quest["state"] == GameManager.QuestState.IN_PROGRESS:
			
			var text = "Missão: " + quest["name"]
			
			# ✔️ se a missão tiver objetivo de item
			if quest["target_item"] != "":
				var current = GameManager.inventory.get(quest["target_item"], 0)
				var required = quest["required_amount"]
				
				text += "\n" + str(current) + "/" + str(required)
			
			label.text = text
			panel.visible = true
			return
	
	label.text = ""
	panel.visible = false
	for id in GameManager.quests:
		var quest = GameManager.quests[id]
		
		if quest["state"] == GameManager.QuestState.IN_PROGRESS:
			label.text = "  Missão: " + quest["name"]
			panel.visible = true
			return
	
	label.text = ""
	panel.visible = false  # nenhuma missão ativa
