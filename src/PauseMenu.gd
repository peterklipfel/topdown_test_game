class_name PauseMenu
extends UIMenu

signal reload_level()
signal restart_game()

func _gui_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close_ui()


func menu_action(action_str: String):
	match action_str:
		"Resume":
			close_ui()
		"Reload":
			close_ui()
			reload_level.emit()
		"Quit":
			close_ui()
			restart_game.emit()
