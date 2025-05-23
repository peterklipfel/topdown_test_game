class_name Player
extends CharacterBody2D

signal player_killed()
signal won()
@export var speed : int = 100

var velocity := Vector2.ZERO
var treasures := 0
var extents : Vector2
var dead := false

func _ready():
	Global.player = self

func get_extents():
	return $CollisionShape2D.shape.size / 2.0

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed


func _physics_process(_delta):
	get_input()
	move_and_slide()


func die(obj, signal_str):
	if not dead:
		dead = true
		set_physics_process(false)
		print("player killed")
		if obj != null:
			await obj[signal_str]
		player_killed.emit()


# must be called during idle period
func disable():
	hide()
	$CollisionShape2D.disabled = true


func enable():
	dead = false
	show()
	set_physics_process(true)
	$CollisionShape2D.disabled = false


func count_treasures():
	treasures = 0
	for level in Global.treasures:
		treasures += Global.treasures[level].size()
	Global.update_treasure.emit()


func add_treasure():
	treasures += 1
	Global.update_treasure.emit()
	if treasures >= Global.ALL_TREASURES:
		won.emit()


func update_camera_limits(rect : Rect2):
	$Camera2D.limit_top = rect.position.y
	$Camera2D.limit_left = rect.position.x
	$Camera2D.limit_bottom = rect.end.y
	$Camera2D.limit_right = rect.end.x
