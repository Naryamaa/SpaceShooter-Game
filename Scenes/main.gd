extends Node2D
const ENEMY = preload("res://Scenes/enemy.tscn")
@onready var label: Label =$CanvasLayer/Label
@onready var game_over_label: Label =$CanvasLayer/GameOverLabel
@onready var game_over_sfx: AudioStreamPlayer2D =$GameOverSFX
@onready var menu_and_restart: VBoxContainer =$VBoxContainer


var _score: int = 0
func spawn_enemy() -> void:
	var new_enemy : Enemy = ENEMY.instantiate()
	new_enemy.enemy_died.connect(_on_enemy_died)
	var vpr: Rect2 = get_viewport_rect()
	var new_x: float = randf_range(
		vpr.position.x + 10,
		vpr.end.x - 10
	)
	new_enemy.position = Vector2(new_x, vpr.position.y)
	get_tree().current_scene.add_child(new_enemy)
	
func _on_enemy_died() -> void:
	_score += 1
	
	label.text = str(_score)
	
func _on_player_player_died() -> void:
	game_over_label.show()
	game_over_sfx.play()
	menu_and_restart.show()
	get_tree().paused = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass #Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	spawn_enemy() # Replace with function body.


func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn") # Replace with function body.
