class_name HUD
extends CanvasLayer

func _ready():
	Global.update_treasure.connect(_on_update_treasure)

func _on_update_treasure():
	$MarginContainer/NinePatchRect/HBoxContainer/value.text = str(Global.player.treasures)
