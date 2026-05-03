extends Area2D

@export var item_id = "fragmento"
@export var item_name = "Fragmento"

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		collect()

func collect():
	print("Coletou:", item_name)
	
	# chama lógica global
	GameManager.collect_item(item_id)
	
	queue_free()
