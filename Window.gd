extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	size=get_parent().get_viewport().size*0.6
	position.x=get_parent().get_viewport().size.x/2-size.x/2
	position.y=get_parent().get_viewport().size.y/2-size.y/2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
