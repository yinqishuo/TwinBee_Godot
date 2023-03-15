extends Area2D

@export var cloud_speed = 100 # How fast the player will move (pixels/sec).
@export var bell_speed =  300
@export var velocity = Vector2.DOWN 
@export var bell: PackedScene
# The player's movement vector.
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(randi_range(0,screen_size[0]),0)

	$AnimatedSprite2D.play()
	var types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = types.pick_random()
	print('新建一个云朵')
	
func _process(delta):
	velocity = velocity.normalized() * cloud_speed
	position += velocity * delta
func _on_area_entered(area):
	print('检测到了')	 
	self.set_deferred("Monitoring",false)
	self.set_deferred("Monitorable",false)
	$CollisionShape2D.set_deferred("disabled",true)
	var bellIns = bell.instantiate()
	bellIns.linear_velocity = Vector2.UP * bell_speed
	bellIns.global_position = global_position
	bellIns.set_as_top_level(true)
	add_child(bellIns)

	
#	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()




