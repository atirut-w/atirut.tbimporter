@tool
extends EditorPlugin


const TOOL_MENU_NAME := "Export TrechBroom game config"
var dialog: EditorFileDialog


func _enter_tree():
	dialog = EditorFileDialog.new()
	dialog.access = EditorFileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	dialog.add_filter("*.cfg", "TrenchBroom game config")
	
	dialog.file_selected.connect(func(path: String):
		_file_dialog_cleanup()
		_export_tb_config(path)
	)
	dialog.canceled.connect(_file_dialog_cleanup)
	
	add_tool_menu_item(TOOL_MENU_NAME, func():
		get_editor_interface().popup_dialog_centered(dialog, Vector2i(800, 600))
		dialog.current_file = "GameConfig.cfg"
	)


func _exit_tree():
	remove_tool_menu_item(TOOL_MENU_NAME)
	dialog.queue_free()


func _file_dialog_cleanup() -> void:
	dialog.get_parent().remove_child(dialog)


func _export_tb_config(path: String) -> void:
	print("Export config")
