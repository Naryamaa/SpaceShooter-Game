extends Area2D
class_name Enemy
@export var speed = 100
signal enemy_died

func _physics_process(delta: float) -> void:
	position.y += speed * delta
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()
		enemy_died.emit()
		queue_free()# Replace with function body.
