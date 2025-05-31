# player_follow_camera.gd
class_name PlayerFollowCamera extends Node2D

@onready var player := %Char_Player
@onready var camera := self.get_node("Camera")
@export var rect_shape: CollisionShape2D
# @onready var camera_manager : = %Camera_Manager
@onready var camera_manager := get_node("/root/World/Camera_Manager")
@onready var phantom_camera_host : PhantomCameraHost = camera_manager.phantom_camera_host

@export var zoom := Vector2(1., 1.)
@onready var lookahead_distance : int = player.speed / 2 / zoom.length()
@export var smoothing := 5.0
@export var return_speed := 2.0
@export var build_speed := 2.0  


func _ready() -> void:
    update_limit_shape()

func start():
    camera.set_priority(1)
    var cam_focus = player.camera_focus
    cam_focus.lookahead_distance = lookahead_distance
    cam_focus.smoothing = smoothing
    cam_focus.return_speed = return_speed
    cam_focus.build_speed = build_speed
    camera.set_zoom(zoom)
    force_camera_to_target()

func end():
    camera.set_priority(0)

func force_camera_to_target():
    camera.set_follow_target(null)
    camera.follow_mode = 0
    await get_tree().process_frame
    camera.global_position = GameState.camera_focus.global_position
    camera.follow_mode = 5
    camera._follow_framed_initial_set = false
    #camera.set_follow_mode(2)
    await get_tree().process_frame
    camera.set_follow_target(player.camera_focus)

func update_limit_shape():
    var shape_node : CollisionShape2D= $CameraLimit
    var shape := shape_node.shape
    shape.extents *= global_scale
    shape_node.shape = shape.duplicate()


func _physics_process(_delta: float) -> void:
    pass
    #var center_position = camera.get_screen_center_position()
    #if player.velocity.length() == 0 and (center_position - camera.get_follow_target().global_position).length() < 50:
    #   camera.follow_mode = 5
