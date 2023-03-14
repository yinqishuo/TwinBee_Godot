extends Area2D

@export var cloud_speed = 100 # How fast the player will move (pixels/sec).
@export var velocity = Vector2.DOWN # The player's movement vector.
var screen_size # Size of the game window.
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(randi_range(0,screen_size[0]),0)
	$AnimatedSprite2D.play('change')
	
func _process(delta):
	velocity = velocity.normalized() * cloud_speed
	position += velocity * delta
	
	
func _on_body_entered(body):
	print('被打中了')	 
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

