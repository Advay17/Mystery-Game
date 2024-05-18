extends Area2D
var tex
@onready var sprite:Sprite2D=$Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var name:="CollisionPolygon2D"
	remove_child($CollisionPolygon2D)
	for i in range(2, 9):
		remove_child(get_node(str(name, i)))
	var texture:=sprite.texture.get_image()
	var bitmap:=BitMap.new()
	bitmap.create_from_image_alpha(texture)
	var hit_array:=bitmap.opaque_to_polygons(Rect2(Vector2(), bitmap.get_size()))
	for i in hit_array:
		var p=CollisionPolygon2D.new()
		p.polygon=i
		p.position.x-=texture.get_width()/2
		p.position.y-=texture.get_height()/2
		add_child(p)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
