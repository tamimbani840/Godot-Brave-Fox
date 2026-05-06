extends Node
# this is a singleton

signal max_health_changed(value: int)
signal health_changed(value: int)
signal zero_health()

var max_health := 3 :
	get: return max_health
	set(v):
		max_health = v if v > 0 else 1
		max_health_changed.emit(max_health)

@onready var health := max_health :
	get: return health
	set(v):
		health = clampi(v, 0, max_health)
		health_changed.emit(health)
		if health <= 0:
			health = 0
			zero_health.emit()
