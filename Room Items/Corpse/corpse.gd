extends CharacterBody2D
@onready var body_area=$Area2D
var dragged=false
var blst=preload("res://Room Items/Clean Up/clean_up.tscn")
@onready var bt=$Timer
func _ready():
	$Area2D/CollisionShape2D.shape.radius=max($Sprite2D.texture.get_width(), $Sprite2D.texture.get_height())+30
	pass


func _on_area_2d_body_entered(body):
	$ActionPrompt.show()
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	$ActionPrompt.hide()
	pass # Replace with function body.
func _process(delta):
	if dragged:
		$ActionPrompt.hide()
		if(body_area.has_overlapping_bodies()):
			velocity=body_area.get_overlapping_bodies()[0].velocity
			if !is_on_wall() || (!(get_wall_normal().x>0 && velocity.x<0) && !(get_wall_normal().y>0 && velocity.y<0) && !(get_wall_normal().x<0 && velocity.x>0) && !(get_wall_normal().y<0 && velocity.y>0)):
				move_and_slide()
		else:
			dragged=false
	elif body_area.has_overlapping_bodies():
		$ActionPrompt.show()
func _unhandled_input(event):
	if body_area.has_overlapping_bodies() && event.is_action_pressed("grab"):
		dragged=!dragged


func _on_timer_timeout():
	if dragged:
		print("runs")
		var s=blst.instantiate()
		var sc=Vector2(randf_range(0.1, 0.2), randf_range(0.1, 0.2))
		s.scale=sc
		s.get_node("ActionPrompt").scale=Vector2(1/sc.x, 1/sc.y)
		s.connect("cleaned", get_parent().get_parent().clean)
		s.global_position=global_position
		get_parent().get_parent().add_child(s)
		get_parent().get_parent().clean_max+=s.get_mess()
	pass
