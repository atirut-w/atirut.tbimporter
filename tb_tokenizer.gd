class_name TBTokenizer
extends RefCounted
## TrenchBroom map file tokenizer. Internally used by TBImport


var tokens: Array[TBToken] = []

var _state := State.DEFAULT
var _buffer := ""
var _position := Vector2i(1,1)

enum State {
	DEFAULT,
	STRING,
	COMMENT,
}


func tokenize(str: String) -> Error:
	var i := 0

	while i < str.length():
		var char := str[i]
		i += 1

		match _state:
			State.DEFAULT:
				match char:
					"\n":
						_flush_buffer()
						_position.x = 1
						_position.y += 1
					"\r":
						pass
					" ":
						_flush_buffer()
						_position.x += 1
					"/":
						if str[i] == "/":
							_state = State.COMMENT
						else:
							return ERR_PARSE_ERROR
					"\"":
						_flush_buffer()
						_state = State.STRING
					_:
						_buffer += char
			State.COMMENT:
				if char == "\n":
					_state = State.DEFAULT
					_position.x = 1
					_position.y += 1
			State.STRING:
				if char == "\"":
					_flush_buffer()
					_position.x += 2 # Account for the quotes
					_state = State.DEFAULT
				else:
					_buffer += char
	
	if _state != State.DEFAULT:
		push_error("reached EOF in non-default state(%d)" % _state)
		return ERR_PARSE_ERROR
	return OK


func _flush_buffer():
	if _buffer != "":
		tokens.append(TBToken.new(_position, _buffer))
		_position.x += _buffer.length()
		_buffer = ""


class TBToken extends RefCounted:
	var position := Vector2i(1,1)
	var value: String


	func _init(position: Vector2i, value: String):
		self.position = position
		self.value = value
