extends PanelContainer

signal selected_boss(boss)

@onready var main_menu = get_tree().get_first_node_in_group("main_menu")

var boss = null


func _ready() -> void:
	connect("selected_boss", Callable(main_menu, "add_selection"))

func _on_choice_name_pressed() -> void:
	emit_signal("selected_boss")
