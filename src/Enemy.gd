class_name Enemy

extends "res://src/Entity.gd"

func _ready():
	if Global.has_enemy(str(name)):
		queue_free()

func player_entered(body: Node2D):
	Global.add_enemy(str(name))
	$EnemySound.play()
	hide()
	set_deferred("monitoring", false)
	await $EnemySound.finished
	queue_free()
