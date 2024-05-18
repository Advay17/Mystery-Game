extends Control
signal new_game
@onready var color = modulate
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_pressed():
	var tween=get_tree().create_tween()
	var color2=color
	color2.a=0
	tween.tween_property(self, "modulate", color2, 3)
	await tween.finished
	new_game.emit()
