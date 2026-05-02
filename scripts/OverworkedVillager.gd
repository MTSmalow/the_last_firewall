extends Node2D

@onready var anim = $AnimatedSprite2D
var dialog_ui = null
var player_in_range = false
var dialog_index = 0
var is_talking = false
var dialogs = [
	"Mercador: Ei… você não parece travado.",
	"Mercador: Ainda responde… isso é bom.",
	"Mercador: Me diz… você também viu as coisas piscando?",
	"Mercador: Tipo… o mundo esquecendo como funciona?",
	"Mercador: Eu comecei a guardar umas coisas estranhas que apareceram por aí.",
	"Mercador: Não são itens normais… são pedaços de sinal.",
	"Mercador: Eu chamo de fragmentos.",
	"Mercador: Eles ficam vibrando… como se estivessem tentando voltar pra algum lugar.",
	"Mercador: Engraçado é que…",
	"Mercador: quando eu chego perto de alguns pontos do mapa… eles reagem.",
	"Mercador: Tem um lugar ali no norte… perto daquele laguinho pequeno.",
	"Mercador: A água não reflete direito. Já reparou?",
	"Mercador: Eu não chego perto dali.",
	"Mercador: As coisas… começam a repetir.",
	"Mercador: Se você for lá… leva um fragmento com você.",
	"Mercador: Talvez ele “responda” ao que quer que esteja lá.",
	"Mercador: E se algo começar a falar com você…",
	"Mercador: não responde rápido demais.",
	"Mercador: Às vezes… não é pra gente entender.",
	"[Voce recebeu um fragmento]",
	"Mercador: …então você sentiu, né?",
	"Mercador: O fragmento ficou mais pesado?",
	"Mercador: Ou… mais 'presente'?",
	"Mercador: Isso significa que você foi notado.",
	"Mercador: O lago não é só água.",
	"Mercador: Aquilo ali é tipo… um ponto quebrado.",
	"Mercador: Algo tá tentando consertar aquele lugar.",
	"Mercador: Mas não tá fazendo direito.",
	"Mercador: Se o fragmento reagir lá…",
	"Mercador: você vai ver.",
	"Mercador: Só não deixa ele “sincronizar” demais com você.",
	"Mercador: Eu já vi gente parar de falar depois disso.",
	"Mercador: Vai lá… mas volta inteiro.",
]


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func start_dialog():
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
