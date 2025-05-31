# transition_zone_two_way.gd
class_name TransitionZoneTwoWay extends Node2D

@export var source_scene: PlayerFollowCamera
@export var target_scene: PlayerFollowCamera
@export var entry_direction: Vector2 = Vector2.RIGHT

@onready var area_source_to_target : = self.get_node("TransitionInDirection")
@onready var area_target_to_source : = self.get_node("TransitionAgainstDirection")
# @onready var camera_manager : = %Camera_Manager
@onready var camera_manager := get_node("/root/World/Camera_Manager")

func _ready():
    area_source_to_target.set_target_scene(target_scene)
    area_target_to_source.set_target_scene(source_scene)
    
    pass
