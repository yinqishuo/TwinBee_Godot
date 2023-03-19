extends Area2D


signal hit
@export var bullet: PackedScene
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var shooting := false
var state = plane_state.ORIGIN
var doppelganger1_position;
var position_queue = []
var doppelganger2_position;
var timer_count = 0;
enum bell_state{
	ORIGIN,
	ADD_SCORE,
	DOUBLE_BULLET,
	DOPPELGANGER
}
enum plane_state{
	ORIGIN,
	ADD_SCORE,
	DOUBLE_BULLET,
	DOPPELGANGER,
	DOPPELGANGER_DOUBLE_BULLET
}
func shoot_bullet(pos,velocity):
	var bulletIns = bullet.instantiate()
	bulletIns.velocity = velocity
	bulletIns.global_position = pos
	#bulletIns.set_as_top_level(true)
	get_parent().add_child(bulletIns)

func _ready():
	screen_size = get_viewport_rect().size
	show()
#	hide()
func _process(delta):
	
	## 发射子弹
	var shoot = Input.is_action_pressed(&"shoot");
	if shoot and not shooting:
		if state == plane_state.ORIGIN:
			## 发射单发子弹
			shoot_bullet(global_position + Vector2(0,-16),Vector2.UP)
		elif state == plane_state.DOUBLE_BULLET:
			## 发射双发子弹
			shoot_bullet(global_position + Vector2(16,-16),Vector2.UP)
			shoot_bullet(global_position + Vector2(-16,-16),Vector2.UP)
		elif state == plane_state.DOPPELGANGER:
			## 发射影分身子弹
			shoot_bullet(global_position + Vector2(0,-16),Vector2.UP)
			shoot_bullet(doppelganger1_position + Vector2(0,-16),Vector2.UP)
			shoot_bullet(doppelganger2_position + Vector2(0,-16),Vector2.UP)
		elif state == plane_state.DOPPELGANGER_DOUBLE_BULLET :
			## 发射影分身子弹
			shoot_bullet(global_position + Vector2(16,-16),Vector2.UP)
			shoot_bullet(global_position + Vector2(-16,-16),Vector2.UP)
			shoot_bullet(doppelganger1_position + Vector2(16,-16),Vector2.UP)
			shoot_bullet(doppelganger1_position + Vector2(-16,-16),Vector2.UP)
			shoot_bullet(doppelganger2_position + Vector2(16,-16),Vector2.UP)
			shoot_bullet(doppelganger2_position + Vector2(-16,-16),Vector2.UP)
		$AudioStreamPlayer.play()
	shooting = shoot
	
	## 影分身
	if state == plane_state.DOPPELGANGER or state == plane_state.DOPPELGANGER_DOUBLE_BULLET :
		position_queue.push_back(global_position) #  储存每一帧的位置
		if position_queue.size()>int(0.3/delta): #   0.3秒延迟
			doppelganger2_position = position_queue.pop_front()
			doppelganger1_position = position_queue[int(position_queue.size()/2)]
		$doppelganger2.global_position = doppelganger2_position
		$doppelganger1.global_position = doppelganger1_position
	## 飞机移动
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"move_right"):
		velocity.x += 1
	if Input.is_action_pressed(&"move_left"):
		velocity.x -= 1
	if Input.is_action_pressed(&"move_down"):
		velocity.y += 1
	if Input.is_action_pressed(&"move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO+Vector2(16,16), screen_size-Vector2(16,16))
	$AnimatedSprite2D.play()

func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()

func _on_area_entered(area):
	if 'Strawberry' in area.get_name():
		print("被打中了")
	if 'bell' in area.get_name():
		#根据不同的铃铛切换不同的状态
		if area.state == bell_state.ORIGIN:#普通铃铛
			print('加分了')

		elif area.state == bell_state.ADD_SCORE:#未知铃铛
			print('双倍加分了')
			#state = plane_state.ADD_SCORE

		elif area.state == bell_state.DOUBLE_BULLET:#双倍子弹铃铛
			if state == plane_state.DOPPELGANGER:
				print('分身+双倍子弹')
				state =  plane_state.DOPPELGANGER_DOUBLE_BULLET
			else :
				print('双倍子弹')
				state =  plane_state.DOUBLE_BULLET

		elif area.state == bell_state.DOPPELGANGER:#分身铃铛
			if state == plane_state.DOUBLE_BULLET :
				print('分身+双倍子弹')
				state =  plane_state.DOPPELGANGER_DOUBLE_BULLET
			else :
				print('影分身')
				state =  plane_state.DOPPELGANGER
			#新建影分身
			$doppelganger1.show()
			$doppelganger2.show()
			$doppelganger2.global_position = global_position
			$doppelganger2.global_position = global_position
			#分身当前所在位置
			doppelganger2_position = global_position
			doppelganger1_position = global_position
			timer_count = 0

