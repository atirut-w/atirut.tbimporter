class_name TBParser
extends RefCounted
## TrenchBroom map parser
## @tutorial(TrenchBroom's View of Maps): https://trenchbroom.github.io/manual/latest/#trenchbrooms-view-of-maps


## Tokenizes a map file
static func tokenize(str: String) -> Array[String]:
	var tokens: Array[String]

	# Remove comments
	var lines: Array[String]
	for line in str.split("\n", false):
		if line.begins_with("//"):
			continue
		lines.append(line.strip_edges())
	var prepared: String = " ".join(lines)

	var buffer: String
	for char in prepared:
		match char:
			"(", ")", "{", "}": # Inclusively split by parentheses and braces
				if buffer.length() > 0:
					tokens.append(buffer)
					buffer = ""
				tokens.append(char)
			" ": # Split by spaces and flush buffer
				if buffer.length() > 0:
					tokens.append(buffer)
					buffer = ""
			_:
				buffer += char
	
	return tokens


## A token
class Token extends RefCounted:
	var position: Vector2i
	var value: String


## Base class for AST nodes
class ASTNode extends RefCounted:
	pass
