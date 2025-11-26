extends Control

# References to nodes
@onready var main_menu: MarginContainer = $Panel/mainMenu
@onready var settings_menu: MarginContainer = $Panel/settingsMenu
@onready var choose_next_menu: MarginContainer = $Panel/chooseNextMenu
@onready var choice_options: VBoxContainer = $Panel/chooseNextMenu/VBoxContainer/chooseScroll/choiceOptions
@onready var displayed_boss: Label = $Panel/mainMenu/VBoxContainer/currentDisplay/displayedBoss
@onready var full_order_list: Label = $Panel/mainMenu/VBoxContainer/informationDisplay/ScrollContainer/fullOrderList
@onready var possible_label: Label = $Panel/mainMenu/VBoxContainer/informationDisplay/ScrollContainer2/possibleNextList
@onready var seed_dynamic_lbl: Label = $Panel/settingsMenu/VBoxContainer/randomizeSettings/seedOptions/seedDynamicLbl
@onready var all_at_once: CheckBox = $Panel/settingsMenu/VBoxContainer/randomizeSettings/allAtOnce
@onready var one_at_a_time: CheckBox = $Panel/settingsMenu/VBoxContainer/randomizeSettings/oneAtATime
@onready var double_gms_check: CheckBox = $Panel/settingsMenu/VBoxContainer/otherSettings/doubleGMS
@onready var black_threads_check: CheckBox = $Panel/settingsMenu/VBoxContainer/otherSettings/blackThreadBosses
@onready var check_docks_first: CheckBox = $Panel/settingsMenu/VBoxContainer/otherSettings/checkDocksFirst
@onready var check_moorwing: CheckBox = $Panel/settingsMenu/VBoxContainer/otherSettings/checkMoorwing
@onready var act_one_limit_check: CheckBox = $Panel/settingsMenu/VBoxContainer/actLimiters/actOneLimit
@onready var act_two_limit_check: CheckBox = $Panel/settingsMenu/VBoxContainer/actLimiters/actTwoLimit
var choice_graphic = preload("res://choiceUI/boss_choice_ui.tscn")

# Strings for functions use
var fullOrderText: String = ""
var possibleNextText: String = ""
var currentBossString: String = ""
var currentBossInt: int = 0

# Sets everything up at runtime
func _ready() -> void:
	Global.rng.randomize()
	if randi_range(1,2) == 1:
		Global.lowerDocksFirst = true
	if randi_range(1,2) == 1:
		Global.moorwingOriginal = true
	seed_dynamic_lbl.set_text(str(Global.rng.seed))
	Global.getBossesDefeated()
	Global.checkOtherReqs()
	Global.getPossibleNext()
	updateBossList()
	updatePossibleNext()
	checkButtons()
	currentBossString = Global.randomBossList[currentBossInt]
	displayed_boss.set_text(currentBossString)

func updateBossList():
	fullOrderText = "Boss List:"
	# Concatenation loop
	for i in Global.randomBossList:
		fullOrderText += "\n" + i
		full_order_list.set_text(fullOrderText)

func updatePossibleNext():
	possibleNextText = "Possible Next:"
	Global.getPossibleNext()
	# Concatenation loop
	if not Global.possibleBossList.is_empty():
		for i in Global.possibleBossList:
			possibleNextText += "\n" + i
			possible_label.set_text(possibleNextText)
	else:
		possible_label.set_text("Possible Next:")

func checkButtons():
	if Global.generateAllOrNot == true:
		all_at_once.button_pressed = true
		one_at_a_time.button_pressed = false
	elif Global.generateAllOrNot == false:
		all_at_once.button_pressed = false
		one_at_a_time.button_pressed = true
	if Global.doubleGMS == true:
		double_gms_check.button_pressed = true
	else:
		double_gms_check.button_pressed = false
	if Global.blackThreads == true:
		black_threads_check.button_pressed = true
	else:
		black_threads_check.button_pressed = false
	if Global.lowerDocksFirst == true:
		check_docks_first.button_pressed = true
	else:
		check_docks_first.button_pressed = false
	if Global.moorwingOriginal == true:
		check_moorwing.button_pressed = true
	else:
		check_moorwing.button_pressed = false
	if Global.actOneLimiter == true:
		act_one_limit_check.button_pressed = true
	else:
		act_one_limit_check.button_pressed = false
	if Global.actTwoLimiter == true:
		act_two_limit_check.button_pressed = true
	else:
		act_two_limit_check.button_pressed = false

func add_selection():
	var option_children = choice_options.get_children()
	for i in option_children:
		i.queue_free()
	choose_next_menu.visible = false
	main_menu.visible = true

func _on_rando_button_pressed() -> void:
	if Global.generateAllOrNot == true:
		Global.randomizeFullList()
	elif Global.generateAllOrNot == false:
		Global.chooseRandomNext()
	updateBossList()
	updatePossibleNext()

func _on_choose_next_pressed() -> void:
	main_menu.visible = false
	choose_next_menu.visible = true
	for i in Global.possibleBossList:
		var instance_options = choice_graphic.instantiate()
		choice_options.add_child(instance_options)

# Restarts and sets everything back to default
func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	Global.possibleBossList.clear()
	Global.randomBossList.clear()
	Global.randomBossList.append("Moss Mother 1")
	Global.lowerDocksFirst = 0
	Global.moorwingOriginal = 0

func _on_prev_button_pressed() -> void:
	if Global.randomBossList.size() == 1:
		currentBossString = Global.randomBossList[currentBossInt]
		displayed_boss.set_text(currentBossString)
	elif Global.randomBossList.size() > 0:
		if currentBossInt < Global.randomBossList.size() && currentBossInt > 0:
			currentBossInt -= 1
		currentBossString = Global.randomBossList[currentBossInt]
		displayed_boss.set_text(currentBossString)

func _on_next_button_pressed() -> void:
	if Global.randomBossList.size() == 1:
		currentBossString = Global.randomBossList[currentBossInt]
		displayed_boss.set_text(currentBossString)
	elif Global.randomBossList.size() > 0:
		if currentBossInt < Global.randomBossList.size() - 1:
			currentBossInt += 1
		currentBossString = Global.randomBossList[currentBossInt]
		displayed_boss.set_text(currentBossString)

# Opens the settings menu and closes the main menu
func _on_settings_button_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true

# Opens the main menu and closes the settings menu
func _on_back_button_pressed() -> void:
	main_menu.visible = true
	settings_menu.visible = false

func _on_all_at_once_pressed() -> void:
	Global.generateAllOrNot = true
	checkButtons()

func _on_one_at_a_time_pressed() -> void:
	Global.generateAllOrNot = false
	checkButtons()

func _on_double_gms_pressed() -> void:
	Global.doubleGMS = not Global.doubleGMS
	checkButtons()

func _on_black_thread_bosses_pressed() -> void:
	Global.blackThreads = not Global.blackThreads
	checkButtons()

func _on_random_seed_btn_pressed() -> void:
	Global.rng.randomize()
	seed_dynamic_lbl.set_text(str(Global.rng.seed))

func _on_enter_seed_lbl_text_submitted(new_text: String) -> void:
	Global.rng.seed = hash(new_text)
	seed_dynamic_lbl.set_text(str(Global.rng.seed))

func _on_check_docks_first_pressed() -> void:
	Global.lowerDocksFirst = not Global.lowerDocksFirst
	checkButtons()

func _on_check_moorwing_pressed() -> void:
	Global.moorwingOriginal = not Global.moorwingOriginal
	checkButtons()

func _on_act_one_limit_pressed() -> void:
	Global.actOneLimiter = not Global.actOneLimiter
	if Global.actOneLimiter == true:
		Global.actTwoLimiter = true
	checkButtons()

func _on_act_two_limit_pressed() -> void:
	Global.actTwoLimiter = not Global.actTwoLimiter
	checkButtons()
