extends Area2D

@export var init_bell_speed = Vector2(0,-500)
var bell_speed = init_bell_speed
var gravityAcceleration = Vector2(0,500)
var screen_size # Size of the game window.
func _ready():
	screen_size = get_viewport_rect().size
	bell_speed = init_bell_speed
	$AnimationPlayer.play("rotate")
func _process(delta):
	# 计算当前位置和下一帧的初速度
	position += bell_speed * delta +0.5 * gravityAcceleration * delta * delta
	bell_speed = bell_speed + gravityAcceleration*delta;
	# 超出下边界删除对象
	if position.y > screen_size[1]:
		print('已删除')
		queue_free()
		

func _on_area_entered(area):
	if area.get_name() == 'plane':
		print("吃到铃铛加分")
		queue_free()	
	if area.get_name() == 'bullet':
		bell_speed = init_bell_speed
