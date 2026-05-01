extends CanvasLayer

@onready var label = $Panel/MarginContainer/Label
@onready var panel = $Panel


func show_dialog(text, duration := 3.0):
	label.text = text
	panel.visible = true
	
	await get_tree().create_timer(duration).timeout
	
	panel.visible = false
