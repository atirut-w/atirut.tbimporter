class_name TBParser
extends RefCounted
## TrenchBroom map parser
## @tutorial(TrenchBroom's View of Maps): https://trenchbroom.github.io/manual/latest/#trenchbrooms-view-of-maps


var map: Map


## Parses a map file
func parse(str: String) -> Map:
	var tokens := tokenize(str)
	var map := Map.new()

	assert(map._parse(tokens) == OK, "Failed to parse map")
	return map


## Tokenizes a map file
static func tokenize(str: String) -> Array[Token]:
	var position := Vector2i(1, 1)
	var tokens: Array[Token]

	var buffer := ""
	var index := 0
	while index < str.length():
		var char := str[index]
		index += 1

		match char:
			"\n":
				if buffer.is_empty() == false:
					tokens.append(Token.new(position, buffer))
					buffer = ""
				position.x = 1
				position.y += 1
			"\r":
				pass
			" ":
				if buffer.is_empty() == false:
					tokens.append(Token.new(position, buffer))
					position.x += buffer.length() + 1
					buffer = ""
				else:
					position.x += 1
			"/":
				if str[index] == "/":
					while index < str.length() and str[index] != "\n":
						index += 1
					buffer = ""
			"\"":
				buffer += char

				while index < str.length():
					char = str[index]
					index += 1

					match char:
						"\"":
							buffer += char
							tokens.append(Token.new(position, buffer))
							position.x += buffer.length()
							buffer = ""
							break
						_:
							buffer += char
			_:
				buffer += char

	return tokens


## A token
class Token extends RefCounted:
	var position: Vector2i
	var value: String


	func _init(position: Vector2i, value: String):
		self.position = position
		self.value = value


class Map extends RefCounted:
	var entities: Array[Entity]


class Entity extends RefCounted:
	var properties: Array[Property]


class Property extends RefCounted:
	var name: String
	var value: String
