extends Area2D
@export var texture:Texture2D
@onready var sprite:Sprite2D=$Sprite2D
var cleaning:=false
@onready var timer:Timer=$Timer
var tween:Tween
var tween2:Tween
var color
# Called when the node enters the scene tree for the first time.
func _ready():
	var name:="CollisionPolygon2D"
	remove_child($CollisionPolygon2D)
	for i in range(2, 9):
		remove_child(get_node(str(name, i)))
	sprite.texture=texture
	var image:=sprite.texture.get_image()
	var bitmap:=BitMap.new()
	bitmap.create_from_image_alpha(image)
	var hit_array:=bitmap.opaque_to_polygons(Rect2(Vector2(), bitmap.get_size()))
	for i in hit_array:
		var p=CollisionPolygon2D.new()
		p.polygon=i
		print(image.get_width()/2)
		p.position.x-=image.get_width()/2
		p.position.y-=image.get_height()/2
		add_child(p)
	$ActionPrompt._set_action("clean")
	timer.timeout.connect(_on_cleaned)
	color=sprite.modulate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _unhandled_input(event):
	if event.is_action_pressed("clean") && has_overlapping_bodies():
		$ActionPrompt/ProgressBar.show()
		cleaning=true
		timer.start(3)
		tween=get_tree().create_tween()
		tween2=get_tree().create_tween()
		var color_2=color
		color_2.a=0
		tween.tween_property(sprite, "modulate", color_2, 3)
		tween2.tween_property($ActionPrompt/ProgressBar, "value", 100, 3)
	if event.is_action_released("clean"):
		$ActionPrompt/ProgressBar.hide()
		cleaning=false
		timer.stop()
		tween.stop()
		tween2.stop()
		$ActionPrompt/ProgressBar.value=0
		sprite.modulate=color
		
	

func _on_body_entered(body):
	$ActionPrompt.show()
	pass # Replace with function body.


func _on_body_exited(body):
	$ActionPrompt.hide()
	pass # Replace with function body.

func _on_cleaned():
	queue_free()
