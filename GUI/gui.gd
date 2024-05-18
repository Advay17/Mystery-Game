extends Control
signal new_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_pressed():
	var tween=get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(0, 0, 0, 0), 3)
	new_game.emit()
