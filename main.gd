extends Node2D

@export var cloud: PackedScene
@export var Strawberry: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var a = randi_range(0,180);
	if not a:
		var cloudins = cloud.instantiate()
		cloudins.global_position = Vector2(randi_range(0,480),0)
		var temp = randi_range(240,480)
		var Strawberryins = Strawberry.instantiate()
		Strawberryins.global_position = Vector2(temp+32,0)
		var Strawberryins2 = Strawberry.instantiate()
		Strawberryins2.global_position = Vector2(temp-32,0)
		var Strawberryins3 = Strawberry.instantiate()
		Strawberryins3.global_position = Vector2(temp,0)
		add_child(cloudins)
		add_child(Strawberryins)
		add_child(Strawberryins2)
		add_child(Strawberryins3)
