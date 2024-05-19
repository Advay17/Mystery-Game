extends Area2D
signal escaped

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_overlapping_bodies():
		for i in range(1, 4):
			if get_node(str("Area2D", i)).has_overlapping_bodies():
				$ActionPrompt.global_position=get_node(str("Area2D", i)).get_node("Marker2D").global_position
				$ActionPrompt.show()
				break
	else:
		$ActionPrompt.hide()

func _unhandled_input(event):
	if has_overlapping_bodies() && event.is_action_pressed("interact"):
		escaped.emit()
