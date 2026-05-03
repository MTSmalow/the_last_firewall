extends Area2D

var triggered = false

var dialogs = [
	"Celular: SINCRONIZAÇÃO INICIADA…",
	"Celular: …",
	"Celular: ERRO",
	"Celular: FONTE NÃO IDENTIFICADA",
	"Eco (fragmentado):…cor… corre…",
	"Eco (fragmentado):…corrig…",
	"Eco (fragmentado):…corrigindo…",
	"Eco (fragmentado): DESORDEM DETECTADA",
	"Eco (fragmentado): DESALINHAMENTO LOCAL",
	"Eco (fragmentado): INICIANDO CORREÇÃO",
	"O fragmento em seu blso parece estar reagindo a algo",
	"Eco (fragmentado): …não…fixo…",
	"Eco (fragmentado): …variável…",
	"Eco (fragmentado): ERRO",
	"Eco (fragmentado): PADRÃO HUMANO NÃO RECONHECIDO",
	"Eco (fragmentado): TENTANDO AJUSTAR",
	"Eco (fragmentado): parar… mover… repetir…",
	"Eco (fragmentado): COMPORTAMENTO INCONSISTENTE",
	"Eco (fragmentado): REESCREVENDO",
	"Celular: ALERTA",
	"Celular: ALTERAÇÃO DETECTADA",
	"Celular: INTERFERÊNCIA BEM-SUCEDIDA",
	"…negação…",
	"…negação…",
	"Eco (fragmentado): CORREÇÃO FALHOU",
	"Eco (fragmentado): ESTADO INSTÁVEL",
	"…registrando…",
	"…novo padrão…",
	"Eco: USUÁRIO NÃO CLASSIFICADO",
	"Eco: …",
	"Celular: ANOMALIA CONTIDA (PARCIAL)",
	"Celular: DADOS COLETADOS",
	"Celular: NEXUS ATIVO",
	"Celular: ECO LOCAL IDENTIFICADO",
	"Celular: STATUS: INSTÁVEL",
	"…você… não… corrigido…"
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
		
