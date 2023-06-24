class_name TBConfigExporter
extends RefCounted


const PLUGIN_PATH := "res://addons/atirut.tbimporter"


static func export(path: String) -> void:
	var base_dir := path.get_base_dir()
	
	var config := FileAccess.get_file_as_string(PLUGIN_PATH + "/templates/config.json")
	var config_file := FileAccess.open(base_dir + "/GameConfig.cfg", FileAccess.WRITE)
	config_file.store_string(config.format({
		name = ProjectSettings["application/config/name"]
	}))
	
	_save_icon(base_dir + "/icon.png")
	FileAccess.open(base_dir + "/entities.fgd", FileAccess.WRITE)


static func _save_icon(path: String) -> void:
	var image := (load(ProjectSettings["application/config/icon"]) as Texture2D).get_image()
	image.resize(32, 32)
	image.save_png(path)
