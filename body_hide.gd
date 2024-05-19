extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_overlapping_bodies() and get_node("../TileMap/Corpse").dragged:
		$ActionPrompt.show()


func _on_action_prompt_pressed():
	if has_overlapping_bodies() and get_node("../TileMap/Corpse").dragged:
		get_node("../TileMap/Corpse").dragged=false
		get_node("../TileMap/Corpse").queue_free()
		get_parent().body_hidden=true
		get_tree().call_group("bh", "queue_free")
