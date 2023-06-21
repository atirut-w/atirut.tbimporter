@tool
extends EditorPlugin


const TOOL_MENU_NAME := "Export TrechBroom game config"
var dialog: EditorFileDialog


func _enter_tree():
	dialog = EditorFileDialog.new()
	dialog.access = EditorFileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	dialog.add_filter("*.cfg", "TrenchBroom game config")
	
	dialog.file_selected.connect(_export_tb_config)
	get_editor_interface().get_base_control().add_child(dialog)
	
	add_tool_menu_item(TOOL_MENU_NAME, func():
		dialog.popup_centered(Vector2i(800, 600))
		dialog.current_file = "GameConfig.cfg"
	)


func _exit_tree():
	remove_tool_menu_item(TOOL_MENU_NAME)
	dialog.queue_free()


func _export_tb_config(path: String) -> void:
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
