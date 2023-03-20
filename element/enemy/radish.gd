extends Area2D
#  白萝卜沿直线行动
@export var radish_speed = 250 # How fast the player will move (pixels/sec).
@export var velocity = Vector2(-1,2)
var screen_size # Size of the game window.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	velocity = Vector2(-1,2)
	velocity = velocity.normalized() * radish_speed
func _process(delta):
	velocity = velocity.normalized() * radish_speed
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
#被子弹打中
func _on_area_entered(area):
	$AnimatedBurst.show()
	$AnimatedBurst.play()
	$AnimatedSprite2D.hide()
	self.set_deferred("Monitoring",false)
	self.set_deferred("Monitorable",false)
	#保持不动
	radish_speed = 0

# 播放完死亡动画
func _on_burst_animation_finished():
	queue_free() 
