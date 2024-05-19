extends CharacterBody2D
@onready var body_area=$Area2D
var dragged=false
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
			print(is_on_wall())
			if !is_on_wall() || (!(get_wall_normal().x>0 && velocity.x<0) && !(get_wall_normal().y>0 && velocity.y<0) && !(get_wall_normal().x<0 && velocity.x>0) && !(get_wall_normal().y<0 && velocity.y>0)):
				move_and_slide()
		else:
			dragged=false
	elif body_area.has_overlapping_bodies():
		$ActionPrompt.show()
func _unhandled_input(event):
	if body_area.has_overlapping_bodies() && event.is_action_pressed("grab"):
		dragged=!dragged
