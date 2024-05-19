extends Control
@onready var label_color=$Label.modulate
var timer:Timer
signal game_started
signal load
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer:
		display_time()
		$ProgressBar.value=get_parent().cleaned

func display_time():
	var timer_label:Label=$Timer
	var minutes=round(timer.time_left/60)
	var seconds=round(fmod(timer.time_left, 60))
	timer_label.text="%02d:%02d" % [minutes, seconds]

func _on_main_menu_new_game():
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
	timer=get_parent().timer
	$Timer.show()
	$ProgressBar.max_value=get_parent().clean_max

func timer_flash():
	var timer_label:Timer=$Timer
	var c:Color=timer_label.modulate
	timer_label.modulate=Color.DARK_RED
	await get_tree().create_timer(0.5).timeout
	var tween=get_tree()
	tween.tween_property(timer_label, "modulate", c, 0.5)
