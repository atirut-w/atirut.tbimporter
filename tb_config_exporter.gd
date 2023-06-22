class_name TBConfigExporter
extends RefCounted


static func export(path: String) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	var dir := DirAccess.open(path.get_base_dir())
	
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
	
	file.store_string(JSON.stringify(config, "    "))
	(load(ProjectSettings["application/config/icon"]) as Texture2D).get_image().save_png(path.get_base_dir() + "/icon.png")
