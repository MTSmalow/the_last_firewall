extends Node2D

@onready var collision = $CharacterBody2D/CollisionShape2D

func _ready():
	check_barrier()

func check_barrier():
	if GameManager.is_quest_completed("ponte"):
		disable_barrier()

func disable_barrier():
	collision.set_deferred("disabled", true)
