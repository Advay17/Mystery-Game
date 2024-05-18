extends Node2D
@onready var timer=$Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_load():
	$TileMap.show()
	get_tree().call_group("mess", "show")



func _on_game_started():
	var player_scene:=load("res://Player/player.tscn")
	var player=player_scene.instantiate()
	player.scale*=0.25
	player.position=$Marker2D.position
	add_child(player)
	timer.start()
	
