@tool
extends EditorPlugin


const TOOL_MENU_NAME := "Export TrechBroom game config"
var dialog: EditorFileDialog
var importer: TBMapImporter


func _enter_tree():
	setup_tool_item()
	
	importer = TBMapImporter.new()
	add_import_plugin(importer)


func _exit_tree():
	remove_tool_menu_item(TOOL_MENU_NAME)
	dialog.queue_free()
	
	remove_import_plugin(importer)
	importer = null


func setup_tool_item() -> void:
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
