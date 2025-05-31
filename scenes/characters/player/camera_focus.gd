extends Marker2D

@export var lookahead_distance := 30.0
@export var smoothing := 5.0
@export var return_speed := 2.0
@export var build_speed := 2.0  # how fast lookahead grows
@export var player : Player


var current_offset := Vector2.ZERO
var target_position := Vector2.ZERO

func _physics_process(delta):
    if player == null:
        return

    var velocity := player.velocity if "velocity" in player else Vector2.ZERO
    var direction := velocity.normalized()

    # Smoothly build or reduce lookahead offset
    var target_offset := Vector2.ZERO
    if direction.length() > 0.1:
        target_offset = direction * lookahead_distance

    # Lerp the offset toward the target_offset (builds up or shrinks gradually)
    current_offset = current_offset.lerp(target_offset, delta * build_speed)

    # Follow the offset target smoothly
    target_position = player.global_position + current_offset
    global_position = global_position.lerp(target_position, delta * smoothing)
