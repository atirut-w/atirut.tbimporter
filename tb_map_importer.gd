class_name TBMapImporter
extends EditorImportPlugin


func _get_importer_name() -> String:
	return "atirut.tbimporter"


func _get_visible_name() -> String:
	return "TrenchBroom Map"


func _get_recognized_extensions() -> PackedStringArray:
	return ["map"]


func _get_save_extension() -> String:
	return "tscn"


func _get_priority() -> float:
	return 1.0


func _get_import_order() -> int:
	return 0


func _get_resource_type() -> String:
	return "PackedScene"


func _get_preset_count() -> int:
	return 1


func _get_preset_name(preset_index: int) -> String:
	return "Default"


func _get_import_options(path: String, preset_index: int) -> Array:
	return []


func _import(source_file: String, save_path: String, options: Dictionary, platform_variants: Array[String], gen_files: Array) -> Error:
	var tokenizer := TBTokenizer.new()
	tokenizer.tokenize(FileAccess.get_file_as_string(source_file))

	for token in tokenizer.tokens:
		print("`%s` at %d:%d" % [token.value, token.position.y, token.position.x])
	
	var root := Node3D.new()

	var scene := PackedScene.new()
	var error := scene.pack(root)
	if error != OK:
		push_error("Error packing scene: %d" % [error])
		return error

	return ResourceSaver.save(scene, "%s.%s" % [save_path, _get_save_extension()])
