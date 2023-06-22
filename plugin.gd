@tool
extends EditorPlugin


const TOOL_MENU_NAME := "Export TrechBroom game config"
var dialog: EditorFileDialog


func _enter_tree():
	dialog = EditorFileDialog.new()
	dialog.access = EditorFileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	dialog.add_filter("*.cfg", "TrenchBroom game config")
	
	dialog.file_selected.connect(func(path: String): TBConfigExporter.export(path))
	get_editor_interface().get_base_control().add_child(dialog)
	
	add_tool_menu_item(TOOL_MENU_NAME, func():
		dialog.popup_centered(Vector2i(800, 600))
		dialog.current_file = "GameConfig.cfg"
	)


func _exit_tree():
	remove_tool_menu_item(TOOL_MENU_NAME)
	dialog.queue_free()
