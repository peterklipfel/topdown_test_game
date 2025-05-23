class_name GameEnd
extends Control

var press_any_key := false

signal switch_menu(menu_name: StringName)
signal restart_game()

# Bad names, but they are necessary to work with UI.gd
func open_menu():
	$PressAnyKey.hide()
	show()
	grab_focus()
	await get_tree().create_timer(0.5).timeout
	press_any_key = true
	$PressAnyKey.show()


func close_menu():
	hide()


func open_ui():
	get_tree().paused = true
	open_menu()


func close_ui():
	close_menu()
	get_tree().paused = false


func _gui_input(event):
	if (event is InputEventKey and event.pressed and not event.is_echo()) or (event is InputEventMouseButton and event.pressed):
		if press_any_key:
			close_ui()
			restart_game.emit()
		get_viewport().set_input_as_handled()
