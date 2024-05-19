extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play():
	var c=$Label.modulate
	$Label.modulate=Color(c.r, c.g, c.b, 0)
	show()
	$ColorRect.show()
	var tween=get_tree().create_tween()
	tween.tween_property($Label, "modulate", c, 3)
	await tween.finished
	await get_tree().create_timer(4).timeout
	get_tree().reload_current_scene()
	
