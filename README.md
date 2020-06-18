<p align="center">
  <img width="250" height="250" src="https://raw.githubusercontent.com/robertcorponoi/graphics/master/godot-toml/godot-toml-logo.png">
</p>

<h1 align="center">Godot Toml</h1>

<p align="center">A script to help you parse toml files in Godot with support for Godot types.<p>

## **Installing**

Since this is not an editor plugin, there's no need to add it to the addons folder like normal plugins. Instead, you just copy the `bin` folder into your project's main directory as it contains everything that's needed to work with it. If you already have a `bin` folder in your project you can just copy the `bin/godot-_toml` folder into it and it will still be picked up. The source for this can be found at [robertcorponoi/godot-toml-source](https://github.com/robertcorponoi/godot-toml-source).

If you would like to see a demo of godot-toml in action, check out the sample project using it in the "sample" folder.

**Note:** This is a nativescript implementation and currently only built to work with Windows and Linux. If you would like to build it yourself for a different platform, feel free to do so by building the [source](https://github.com/robertcorponoi/godot-toml-source) and create a pull request to add the dynamic library to the `bin` folder along with a gdnlib modification so that others may also use it.

## **Usage**

So there's two ways to use the plugin, either through loading the script onready or by using a singleton pattern and we'll go over both ways.

For the following examples, let's assume the `test.toml` file used contains the following data:

```toml
[player]
name = "Bob"
health = 100
attack = 50.5

[enemy]
name = "Ogre"
position = "Vector2(10, 10)"
```

## **Instancing**

For this method, you preload the script and create an instance of it in the script you'd like to use it in like so:

```py
extends Node

onready var toml = preload("res://bin/godot_toml/godot_toml.gdns").new()
```

From here you can use parse a toml file like so and use it's values:

```py
func _ready():
    var parsed = toml.parse("res:://test.toml")
    # Getting the player's health
    print(parsed.player.health)
    # Getting the enemy's location
    print(parsed.enemy.location)
```

## **Singleton**

For this method, you have to follow Godot's instructions on autoloading a script:

1. Go to `Project -> Project Settings` from the menu and switch to the "AutoLoad" tab.
2. Add a new script to autoload, name it "GodotToml" and set it to use the `bin/godot_toml/godot_toml.gdns` script.

Now in the node that you want to use the script on, you can use:

```py
var toml = get_node("/root/GodotToml")
var parsed = toml.parse("res:://test.toml")
```

and the rest works the same way as with the previous method.

## **Godot Types**

You might have noticed in our sample toml file that we have the enemy's position set to a `Vector2` in a string. This is a feature of godot_toml that allows you to use some Godot types in your toml and when parsed they can treated exactly as you would treat any other Vector2, Vector3, etc. These types are not a part of the toml specification so they have to be enclosed in a string to be valid.

The Godot types that can be used are:

### **Vector2**

```toml
position = "Vector2(5, 10)"
```

### **Vector3**

```toml
position = "Vector3(5, 10, 4)"
```

### **Color**

Without alpha:

```toml
background = "Color(255, 255, 255)"
```

With alpha:

```toml
background = "Color(255, 255, 255, 0.5)"
```

### **Rect2**

```toml
room = "Rect2(Vector2(0, 0), Vector2(300, 500))"
```

### **Plane**

```toml
yard = "Plane(Vector3(3, 5, 9), 4)"
```

### **Transform2D**

```toml
placement = "Transform2D(Vector2(5, 10), Vector2(10, 15), Vector2(3, 7))"
```

### **Transform**

```toml
placement = "Transform(Basis(Vector3(8, 0, 1), Vector3(9, 2, 12), Vector3(10, 5, 15)), Vector3(2, 5, 9))"
```

### **Basis**

```toml
matrix = "Basis(Vector3(0, 4, 8), Vector3(1, 5, 9), Vector3(2, 6, 10))"
```

## **Roadmap**

The following items are on the list to be added in future versions:

- Support for more Godot types

## **Tests**

The test toml and script file can be found in the `tests` folder and they can be used to run the suite of tests for godot_toml.

## **License**

MIT
