extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play(body_found:bool, percent:float):
	print(body_found)
	show()
	if body_found:
		$Escaped.text="Body Found"
		$Details.text="The police apprehended you soon, and you are charged with a most grusome murder. Enjoy prison!"
	elif percent<0.2:
		$Details.text="However, the police could tell from a glance that a murder occured, and the evidence left behind showed that you were the perpetrator. Enjoy prison!"
	elif percent<0.7:
		$Details.text="The police found traces of blood, indicating a struggle, yet they were unable to identify who the murderer was. Still, you are a prime suspect, and shall be facing trial."
	else:
		$Details.text="The police could not find a shred of evidence to suggest that anything occured at the house, and by the time they found the body in its hiding place days later, you had already been on a plane to Tahiti."
	$Percentage.text=str(floor((percent+0.001)*100), "% of the evidence cleaned.")
	var tween=get_tree().create_tween()
	modulate=Color(modulate.r, modulate.g, modulate.b, 0)
	tween.tween_property(self, "modulate", Color(modulate.r, modulate.g, modulate.b, 255), 1)
	await tween.finished
	await get_tree().create_timer(4).timeout
	get_tree().reload_current_scene()
	pass
