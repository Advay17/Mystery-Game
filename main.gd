extends Node2D
@onready var timer=$Timer
var splatter=preload("res://Room Items/Clean Up/clean_up.tscn")
var cleaned:int=0
var clean_max:float=0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_load():
	$TileMap.show()
	get_tree().call_group("mess", "show")
	var corpse_position=$TileMap/Path2D/CorpsePosition
	corpse_position.progress_ratio=randf()
	$TileMap/Corpse.global_position=corpse_position.global_position
	for i in range(randi()%30):
		var s=splatter.instantiate()
		var sc=Vector2(randf_range(0.1, 0.2), randf_range(0.1, 0.2))
		s.scale=sc
		s.get_node("ActionPrompt").scale=Vector2(1/sc.x, 1/sc.y)
		corpse_position.progress_ratio=randf()
		s.global_position=corpse_position.global_position
		s.connect("cleaned", clean)
		add_child(s)
		clean_max+=s.get_mess()
		pass



func _on_game_started():
	var player_scene:=load("res://Player/player.tscn")
	var player=player_scene.instantiate()
	player.scale*=0.25
	player.position=$Marker2D.position
	add_child(player)
	timer.start()

func time_loss(time:int):
	timer.time_left-=time
	$GUI.timer_flash()
	pass

func clean(mess):
	cleaned+=mess
