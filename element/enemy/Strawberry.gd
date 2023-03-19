extends Area2D

@export var Strawberry_speed = 250 # How fast the player will move (pixels/sec).
@export var velocity = Vector2(-1,2)
var screen_size # Size of the game window.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	velocity = Vector2(-1,2)
	velocity = velocity.normalized() * Strawberry_speed
func _process(delta):
	velocity = velocity.normalized() * Strawberry_speed
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
func _on_area_entered(area):
	queue_free() 


func _on_monitor_area_entered(area):
	print('检测到玩家')
	if (area.global_position - global_position).x>0:
		velocity = Vector2(1,1)
	else:
		velocity = Vector2(-1,1)
	#velocity = area.global_position - global_position
	
