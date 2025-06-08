class_name Player extends CharacterBody2D

@export var speed: int = 35
@onready var animations := $AnimationPlayer
@onready var camera_focus := $CameraFocus
enum input_state {IDLE, INPUT_LOCKED}

@export var current_input_state := input_state.IDLE

var direction = "down"

var input_buffer := {}
var input_buffer_time := 0.1  # Time in seconds to keep the buffer

func _ready() -> void:
    GameState.player = self
    GameState.camera_focus = camera_focus

func handleInput():
    match current_input_state:
        input_state.INPUT_LOCKED:
            pass
        input_state.IDLE:
            var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
            velocity = move_direction * speed


func lock_controls():
    current_input_state = input_state.INPUT_LOCKED

func unlock_controls():
    current_input_state = input_state.IDLE

func updateAnimation():
    if velocity.length() > 0:
        if abs(velocity.x) > abs(velocity.y):
            if velocity.x < 0 : direction = "left"
            else: direction = "right"
        else:
            if velocity.y < 0 : direction = "up"
            else: direction = "down"
    
    if velocity.length() > 0:
        animations.play("walk_" + direction)
    else:
        animations.play("idle_" + direction)

func _physics_process(_delta):
    handleInput()
    move_and_slide()
    updateAnimation()
