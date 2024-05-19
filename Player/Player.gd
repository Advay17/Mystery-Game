extends CharacterBody2D
@onready var sprite=$Sprite2D
@onready var hitbox=$CollisionPolygon2D
@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	if velocity.x!=0 || velocity.y!=0:
		sprite.play()
	else:
		sprite.stop()
	var texture=sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	hitbox.shape.size=texture.get_size()
	move_and_slide()
	if get_last_slide_collision():
		if get_last_slide_collision().get_collider() is RigidBody2D && get_last_slide_collision().get_collider().broken==false:
			get_last_slide_collision().get_collider()._on_body_entered(self)
