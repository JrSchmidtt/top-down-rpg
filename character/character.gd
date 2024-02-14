extends CharacterBody2D

var state_machine

@export_category("Variables")
@export var move_speed: float = 64.00
@export var friction: float = 0.2
@export var acceleration: float = 0.2

@export_category("Objects")
@export var animation_tree: AnimationTree = null

func _ready():
	state_machine = animation_tree.get("parameters/playback")

# Physics process is called every frame. It's used to handle the character's movement.
func _physics_process(_delta):
	move()
	animate()
	move_and_slide()

# Move top-down character based on input.
func move():
	var direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
		velocity.x = lerp(velocity.x, direction.normalized().x * move_speed, acceleration)
		velocity.y = lerp(velocity.y, direction.normalized().y * move_speed, acceleration)
		return

	velocity.x = lerp(velocity.x, direction.normalized().x * move_speed, friction)
	velocity.y = lerp(velocity.y, direction.normalized().y * move_speed, friction)

# Animate the character based on input.
func animate():
	if velocity.length() > 10:
		state_machine.travel("walk")
		return
	state_machine.travel("idle")
