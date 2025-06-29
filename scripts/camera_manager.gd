# camera_manager.gd
class_name CameraManager extends Node2D

@onready var player = %Char_Player
@onready var current_zone : PlayerFollowCamera 
@onready var old_zone : PlayerFollowCamera

@export var camera_spawn : PlayerFollowCamera
@onready var camera_target : = %Char_Player/CameraFocus  # Or from GameState
@onready var phantom_camera_host : PhantomCameraHost = self.get_node("PlayerCamera").get_node("MyPhantomCameraHost")


func _ready():
    self.get_node("PlayerCamera").make_current()
    await get_tree().process_frame
    camera_spawn.start()


func updateCamera(zone):
    if zone == current_zone:
        return    

    old_zone = current_zone
    current_zone = zone
    
    current_zone.start()
    if not old_zone == null:
        old_zone.end()
