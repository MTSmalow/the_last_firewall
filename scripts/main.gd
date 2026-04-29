extends Node

@onready var player = $Player/CharacterBody2D
@onready var life_bar = $CanvasLayer/ProgressBar

func _ready():
	player.life_bar = life_bar
