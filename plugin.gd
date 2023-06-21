@tool
extends EditorPlugin


const TOOL_MENU_NAME := "Export TrechBroom game config"
var dialog: EditorFileDialog


func _enter_tree():
	add_tool_menu_item(TOOL_MENU_NAME, _export_tb_config)
	
	dialog = EditorFileDialog.new()
	dialog.access = EditorFileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = EditorFileDialog.FILE_MODE_OPEN_DIR
	dialog.dir_selected.connect(_write_tb_config)


func _exit_tree():
	remove_tool_menu_item(TOOL_MENU_NAME)
	dialog.queue_free()


func _export_tb_config() -> void:
	get_editor_interface().popup_dialog_centered(dialog, Vector2i(800, 600))


func _write_tb_config(dir: String) -> void:
	dialog.get_parent().remove_child(dialog)
