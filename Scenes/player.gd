extends Area2D
class_name Player
@export var speed: float = 200
@onready var laser_sound: AudioStreamPlayer2D = $LaserSound
const BULLET = preload("res://Scenes/bullet.tscn")
signal player_died

func shoot() -> void:
	# Create a new bullet instance
	var new_bullet: Bullet = BULLET.instantiate() 
	# Set bullet position to the player's position
	get_tree().current_scene.add_child(new_bullet)

	# Add the bullet to the current scene
	new_bullet.global_position = global_position 
	# Play shooting sounds
	laser_sound.play() 
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shoot()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var vpr = get_viewport_rect()
	var direction: float = 0
	if Input.is_action_pressed("right"):
		direction = 1
	if Input.is_action_pressed("left"):
		direction = -1
	var movement = direction*speed*delta
	position.x += movement
	position.x = clampf(position.x, vpr.position.x + 15, vpr.end.x - 15)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		player_died.emit() # Replace with function body.
