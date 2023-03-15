extends Area2D


signal hit
@export var bullet: PackedScene
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var shooting := false


func _ready():
	screen_size = get_viewport_rect().size
	show()
#	hide()
	


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"move_right"):
		velocity.x += 1
	if Input.is_action_pressed(&"move_left"):
		velocity.x -= 1
	if Input.is_action_pressed(&"move_down"):
		velocity.y += 1
	if Input.is_action_pressed(&"move_up"):
		velocity.y -= 1
	##发射子弹
	var shoot = Input.is_action_pressed(&"shoot");
	if shoot and not shooting:
		var bulletIns = bullet.instantiate()
		bulletIns.velocity = Vector2.UP
		bulletIns.global_position = global_position + Vector2(0,-16)
		bulletIns.set_as_top_level(true)
		add_child(bulletIns)
		
	shooting = shoot
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed
#		$AnimatedSprite2D.play()
#	else:
#		$AnimatedSprite2D.stop()
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO+Vector2(16,16), screen_size-Vector2(16,16))
#	print(position)
	$AnimatedSprite2D.play()
#	if velocity.x != 0:
#		$AnimatedSprite2D.animation = &"right"
#		$AnimatedSprite2D.flip_v = false
#		$AnimatedSprite2D.flip_h = velocity.x < 0
#	elif velocity.y != 0:
#		$AnimatedSprite2D.animation = &"up"
#		$AnimatedSprite2D.flip_v = velocity.y > 0

func start(pos):
	position = pos
	show()
#	$CollisionShape2D.disabled = false
func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()

#func _on_Player_body_entered(_body):
#	hide() # Player disappears after being hit.
#	hit.emit()
##	# Must be deferred as we can't change physics properties on a physics callback.
##	$CollisionShape2D.set_deferred(&"disabled", true)



