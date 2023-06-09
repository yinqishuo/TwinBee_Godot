extends Area2D
# 草莓当检测到周围有玩家时就会
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
#被子弹打中
func _on_area_entered(area):
	$AnimatedBurst.show()
	$AnimatedBurst.play()
	$AnimatedSprite2D.hide()
	self.set_deferred("Monitoring",false)
	self.set_deferred("Monitorable",false)
	$MonitorArea.set_deferred("Monitoring",false)
	#保持不动
	Strawberry_speed = 0
	


func _on_monitor_area_entered(area):
	print('检测到玩家')
	if (area.global_position - global_position).x>0:
		velocity = Vector2(1,1)
	else:
		velocity = Vector2(-1,1)
	Strawberry_speed = 400 
	#velocity = area.global_position - global_position
	

# 播放完死亡动画
func _on_burst_animation_finished():
	print('结束了')
	queue_free() 
