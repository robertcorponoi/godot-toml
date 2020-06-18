extends Node

# Preload the script and make an instance of it.
var toml = preload("res://bin/godot_toml/godot_toml.gdns").new()

# Run our tests here.
func _ready():
	# Parse the test.toml file into a dictionary.
	var parsed = toml.parse_toml("res://test/test.toml")
	# Standalone field
	assert(parsed.greeting == "Hello, world!")
	# Tables with various data types.
	assert(parsed.player.name == "Bob")
	assert(parsed.player.health == 88)
	assert(parsed.player.attack == 5)
	assert(parsed.player.defence == 10)
	assert(parsed.player.birthdate == "1979-05-27")
	assert(parsed.enemy.name == "Sentinel")
	assert(parsed.enemy.toughness == 9.8)
	assert(parsed.enemy.is_boss == true)
	assert(parsed.enemy.hint == "Try using slash weapons (longsword, scimitar, etc.)")
	# Tables with objects
	assert(parsed.shop.inventory.items == 5)
	assert(parsed.shop.inventory.gold == 100)
	assert(parsed.shop.keeper.name == "Frank")
	assert(parsed.shop.keeper.age == 50)
	# Array
	assert(parsed.weapons.size() == 2)
	assert(parsed.weapons[0].name == "sword")
	assert(parsed.weapons[0].attack == 3)
	assert(parsed.weapons[1].name == "bow")
	assert(parsed.weapons[1].attack == 2)
	# Godot types
	# ===================================
	# Vector2
	assert(parsed.godot.position_2 == Vector2(5, 10))
	# Vector3
	assert(parsed.godot.position_3 == Vector3(3, 5, 7))
	# Color
	assert(parsed.godot.background == Color(255, 255, 255))
	assert(parsed.godot.background_with_alpha == Color(250, 150, 100, 0.5))
	# Rect2
	assert(parsed.godot.living_room == Rect2(Vector2(5, 10), Vector2(300, 500)))
	# Plane
	assert(parsed.godot.yard == Plane(Vector3(3, 5, 9), 4))
	# Transform2D
	assert(parsed.godot.location_2 == Transform2D(Vector2(5, 10), Vector2(10, 15), Vector2(3, 7)))
	# Basis
	assert(parsed.godot.matrix == Basis(Vector3(0, 4, 8), Vector3(1, 5, 9), Vector3(2, 6, 10)))
	# Transform
	assert(parsed.godot.location_3 == Transform(Basis(Vector3(8, 0, 1), Vector3(9, 2, 12), Vector3(10, 5, 15)), Vector3(2, 5, 9)))
