class_name UndoStack
extends Node

const MAX_UNDOS = 20

var changes : Array[Resource]

#region Stack
#add a previous project state
func add_state(undo_info: UndoInfo) -> void:
	changes.push_back(undo_info)

	if changes.size() >= MAX_UNDOS:
		changes.pop_front()

#restore the last project state
func restore_state(project: Project) -> void:
	var state = changes.pop_back() as UndoInfo
	if state != null:
		state.restore(project)

func clear_stack() -> void:
	changes.clear()
#endregion

#region EventActions
func _on_create_page(index: int) -> void:
	add_state(PageCreateUndoInfo.new(index))

func _on_delete_page(page: Page, index: int) -> void:
	add_state(PageDeleteUndoInfo.new(page, index))
#endregion
