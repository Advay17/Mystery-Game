extends RigidBody2D
var broken:=false
@export var spriteframes:SpriteFrames
@onready var hitbox:CollisionPolygon2D=$CollisionPolygon2D
@onready var sprite:AnimatedSprite2D=$AnimatedSprite2D
signal time_loss(time:int)
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.sprite_frames=spriteframes
	sprite.set_autoplay("default")
	var default_sprite:=sprite.sprite_frames.get_frame_texture("default", 0).get_image()
	var bitmap:=BitMap.new()
	bitmap.create_from_image_alpha(default_sprite)
	var array=bitmap.opaque_to_polygons(Rect2(Vector2(), bitmap.get_size()))
	for i in array:
		var p=CollisionPolygon2D.new()
		p.polygon=i
		p.position.x-=default_sprite.get_width()/2
		p.position.y-=default_sprite.get_height()/2
		add_child(p)
	connect("time_loss", get_parent().time_loss)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Collision logic
func _on_body_entered(body):
	sprite.play("falling")
	await sprite.animation_looped
	sprite.play("broken")
	time_loss.emit(5)
	hitbox.queue_free()
