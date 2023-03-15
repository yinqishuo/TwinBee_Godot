extends Node2D

@export var cloud: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var a = randi_range(0,180);
	if not a:
		var cloudins = cloud.instantiate()
		cloudins.global_position = Vector2(randi_range(0,480),0)
		add_child(cloudins)
