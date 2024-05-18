extends RigidBody2D
var broken:=false
@export var spriteframes:SpriteFrames
@onready var hitbox:CollisionPolygon2D=$CollisionPolygon2D
@onready var sprite:AnimatedSprite2D=$AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.sprite_frames=spriteframes
	sprite.set_autoplay("default")
	var default_sprite:=sprite.sprite_frames.get_frame_texture("default", 0).get_image()
	var bitmap:=BitMap.new()
	bitmap.create_from_image_alpha(default_sprite)
	hitbox.polygon=bitmap.opaque_to_polygons(Rect2(Vector2(), bitmap.get_size()))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Collision logic
func _on_body_entered(body):
	sprite.play("falling")
	await sprite.animation_looped
	sprite.play("broken")
	hitbox.queue_free()
