class_name Trap
extends Entity

func player_entered(body: Node2D):
	if body.has_method("die"):
		$TrapSound.play()
		body.die(null, "")
