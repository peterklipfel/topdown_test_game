class_name Gate
extends Node2D

signal exitted_scene(destination_scene: String, destination_gate: String, offset_pct: float)
@export var is_horizontal : bool = false
@export_file("*.tscn") var destination_scene : String
@export var destination_gate : String

func _on_Exit_area_entered(area: Area2D):
	var idx = 0 if is_horizontal else 1
	var offset = area.global_position[idx] - $Exit.global_position[idx]
	var max_offset = $Exit/CollisionShape2D.shape.size[idx] / 2.0 - \
	                 Global.player.get_extents()[idx]
	var offset_pct = 0.0 # Ensure float for division
	if max_offset > 0: # Check to prevent division by zero if max_offset is not positive
		offset_pct = offset / max_offset
		if offset >= max_offset: # This check should ideally use the calculated offset_pct or be before it
			offset_pct = 1.0
	elif offset >=0: # Handle cases where max_offset might be zero or negative, but offset is positive
		offset_pct = 1.0
	# Ensure offset_pct is clamped if necessary, or rethink logic if area can be larger than gate
	# For simplicity now, just ensuring it doesn't exceed 1 based on original logic
	offset_pct = clampf(offset_pct, 0.0, 1.0) # Assuming offset_pct should not be negative here

	print("player entered ", destination_scene, ", ", destination_gate, ": ", offset_pct)
	exitted_scene.emit(destination_scene, destination_gate, offset_pct)


func enter_gate(offset_pct: float):
	var idx = 0 if is_horizontal else 1
	var pos = $Entrance.global_position
	var max_offset = $Entrance/CollisionShape2D.shape.size[idx] / 2.0 - \
	                 Global.player.get_extents()[idx]
	var offset = 0.0 # Ensure float
	offset_pct = clampf(offset_pct, -1.0, 1.0)
	if max_offset > 0:
		offset = offset_pct * max_offset
	pos[idx] = pos[idx] + offset
	Global.player.global_position = pos
