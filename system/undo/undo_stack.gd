class_name UndoStack
extends Node

signal undo

const maxUndos = 20

var changes : Array[Resource]
#region Stack

func add_state(undo_info: UndoInfo) -> void:
	#print("[UndoStack] added undo entry")
	changes.push_back(undo_info)
	
	if changes.size() >= maxUndos:
		changes.pop_front()
		
func restore_state(project: Project) -> void:
	#print("[UndoStack] restored state")
	var state = changes.pop_back() as UndoInfo
	if state != null:
		state.restore(project)
		undo.emit()
	
func clear_stack() -> void:
	changes.clear()
#endregion

#region EventActions

func _on_create_page(index: int) -> void:
	add_state(PageCreateUndoInfo.new(index))
	
func _on_delete_page(page: Page, index: int) -> void:
	add_state(PageDeleteUndoInfo.new(page, index))
#endregion
