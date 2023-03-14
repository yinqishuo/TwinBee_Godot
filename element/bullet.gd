extends Area2D


@export var bullet_speed = 600 # How fast the player will move (pixels/sec).
@export var velocity = Vector2.ZERO # The player's movement vector.
var screen_size # Size of the game window.
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	velocity = velocity.normalized() * bullet_speed
	position += velocity * delta
	
func _on_body_entered(body):
	queue_free() 
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

