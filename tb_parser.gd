class_name TBParser
extends RefCounted
## TrenchBroom map parser


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
