extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 64.00
@export var friction: float = 0.8
@export var acceleration: float = 0.5

# Physics process is called every frame. It's used to handle the character's movement.
func _physics_process(delta):
	move()
	move_and_slide()

# Move top-down character based on input.
func move():
	var direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	if direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x, direction.normalized().x * move_speed, acceleration)
		velocity.y = lerp(velocity.y, direction.normalized().y * move_speed, acceleration)
		return

	velocity.x = lerp(velocity.x, direction.normalized().x * move_speed, friction)
	velocity.y = lerp(velocity.y, direction.normalized().y * move_speed, friction)
