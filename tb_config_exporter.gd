class_name TBConfigExporter
extends RefCounted


static func export(path: String) -> void:
	var base_dir := path.get_base_dir()
	var config := {}
	
	config.version = 6
	config.name = ProjectSettings["application/config/name"]
	config.icon = "icon.png"
	
	config.fileformats = [
		{
			format = "Standard"
		}
	]
	
	config.filesystem = {
		searchpath = "",
		packageformat = {
			extension = "zip",
			format = "zip"
		}
	}
	
	config.textures = {
		package = {
			type = "directory",
			root = ""
		},
		format = {
			format = "image",
			extensions = [
				"png"
			]
		}
	}
	
	config.entities = {
		definitions = [],
		defaultcolor = "1.0 1.0 1.0 1.0"
	}
	
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(config, "    "))
	_save_icon(base_dir + "/icon.png")


static func _save_icon(path: String) -> void:
	var image := (load(ProjectSettings["application/config/icon"]) as Texture2D).get_image()
	image.resize(32, 32)
	image.save_png(path)
