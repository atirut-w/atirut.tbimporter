class_name TBMapImporter
extends EditorImportPlugin


func _get_importer_name() -> String:
	return "atirut.tbimporter"


func _get_visible_name() -> String:
	return "TrenchBroom map"


func _get_recognized_extensions() -> PackedStringArray:
	return ["map"]


func _get_save_extension() -> String:
	return "tscn"


func _get_resource_type() -> String:
	return "PackedScene"


func _get_preset_count() -> int:
	return 1


func _get_preset_name(preset_index: int) -> String:
	return "Default"


func _get_import_options(path: String, preset_index: int) -> Array:
	return []


func _import(source_file: String, save_path: String, options: Dictionary, platform_variants: Array, gen_files: Array) -> int:
	return OK
