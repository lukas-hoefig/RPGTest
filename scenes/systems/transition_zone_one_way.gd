# transition_zone_one_way.gd
class_name TransitionZoneOneWay extends Area2D

@export var target_scene: PlayerFollowCamera
@onready var area : = self 
@export var entry_direction: Vector2 = Vector2.RIGHT
# @onready var camera_manager : = %Camera_Manager
@onready var camera_manager := get_node("/root/World/Camera_Manager")

func _ready():
    entry_direction = Vector2.RIGHT.rotated(get_global_rotation()).normalized()
    if not area == null:
        area.body_entered.connect(_on_area_body_entered)
    
func _on_area_body_entered(body):
    var to_player = body.velocity.normalized().dot(entry_direction)
    # Check if entry roughly matches the intended direction
    if to_player > 0.0:
        camera_manager.updateCamera(target_scene)
        
func set_entry_direction(vec : Vector2):
    entry_direction = vec

func set_target_scene(new_target_scene : PlayerFollowCamera):
    target_scene = new_target_scene
