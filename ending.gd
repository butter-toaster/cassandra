extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	%ambience.play()
	create_tween().tween_property(%photo1, "modulate", Color.WHITE, 6)
	await get_tree().create_timer(8).timeout
	create_tween().tween_property(%photo2, "modulate", Color.WHITE, 6)
	await get_tree().create_timer(8).timeout
	create_tween().tween_property(%cassandra, "modulate", Color.WHITE, 1.2)
	await get_tree().create_timer(1.75).timeout
	create_tween().tween_property(%credit, "modulate", Color.WHITE, 1.2)
	await get_tree().create_timer(1.5).timeout
	create_tween().tween_property(%toaststudios, "modulate", Color.WHITE, 1.2)
