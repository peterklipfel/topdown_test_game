class_name StartMenu
extends UIMenu

signal start_game()
signal continue_game()

func menu_action(action_str: String):
	match action_str:
		"Start":
			close_ui()
			start_game.emit()
		"Continue":
			close_ui()
			continue_game.emit()
		"Quit":
			get_tree().quit()

func open_menu():
	if not FileAccess.file_exists(Global.SAVE_FILE):
		$Menu/Continue.hide()
		$Menu/Start.text = "Start"
	else:
		$Menu/Continue.show()
		$Menu/Start.text = "Restart"
	super.open_menu()
