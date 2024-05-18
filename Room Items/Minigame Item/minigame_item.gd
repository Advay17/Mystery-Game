extends StaticBody2D
@export var texture:Texture2D
@onready var sprite:Sprite2D=$Sprite2D
enum Icons {
	AUTOMATIC,
	XBOX,
	SONY,
	NINTENDO,
	KEYBOARD,
}
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture=texture
	var image:=sprite.texture.get_image()
	var bitmap:=BitMap.new()
	bitmap.create_from_image_alpha(image)
	var hit_array:=bitmap.opaque_to_polygons(Rect2(Vector2(), bitmap.get_size()))
	for i in hit_array:
		var p=CollisionPolygon2D.new()
		p.polygon=i
		p.position.x-=image.get_width()/2
		p.position.y-=image.get_height()/2
		add_child(p)
	$Area2D/CollisionShape2D.shape.radius=max(image.get_width(), image.get_height())+20
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	$Area2D.show()



func _on_area_2d_body_exited(body):
	$Area2D.hide()
