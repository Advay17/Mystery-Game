extends Control
@onready var label_color=$Label.modulate
signal game_started
signal load
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_new_game():
	print("runs")
	load.emit()
	$Label.show()
	var tween=get_tree().create_tween()
	var c=label_color
	c.a=0
	tween.tween_property($Label, "modulate", c, 2)
	await tween.finished
	tween.stop()
	$Label.modulate=label_color
	c=label_color
	c.a=0
	$Label.text="Hide the Evidence!"
	tween=get_tree().create_tween()
	tween.tween_property($Label, "modulate", c, 0.5)
	await tween.finished
	game_started.emit()
