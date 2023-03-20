extends Area2D
# 蜜蜂飞机抛物线运行，靠近玩家发射子弹(2种方向，2种轨迹)
@export var bee_speed = 250 # How fast the player will move (pixels/sec).
@export var direction = true
@export var followPath = 0   
var screen_size # Size of the game window.
var last_pos = 0
var path
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	direction = true
	followPath = 0
func _process(delta):
	if followPath:
#		$Path2D/PathFollow2D.rotates = direction
		last_pos += bee_speed * delta
		$Path2D/PathFollow2D.progress= last_pos
		position =  $Path2D/PathFollow2D.position
	else: 
#		$Path2D2/PathFollow2D2.rotates = direction
		last_pos += bee_speed * delta
		$Path2D2/PathFollow2D2.progress= last_pos
		position =  $Path2D2/PathFollow2D2.position
func _on_visible_on_screen_notifier_2d_screen_exited():
	print('删除了')
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
	bee_speed = 0
	


func _on_monitor_area_entered(area):
	print('检测到玩家')
	#velocity = area.global_position - global_position
	

# 播放完死亡动画
func _on_burst_animation_finished():
	print('结束了')
	queue_free() 
